describe Eldr::Rendering::Tags do
  describe '#tag' do
    it 'supports tags with no content and no attributes' do
      expect(tag(:br)).to have_tag(:br)
    end

    it 'supports tags with no content with attributes' do
      html = tag(:br, :style => 'clear:both', :class => 'yellow')
      expect(html).to have_tag('br', :with => {:class => 'yellow', :style => 'clear:both'})
    end

    it 'supports selected attribute by using "selected" if true' do
      html = tag(:option, :selected => true)
      expect(html).to have_tag('option', :with => {:selected => 'selected'})
    end

    it 'supports data attributes' do
      html = tag(:a, :data => { :remote => true, :method => 'post'})
      expect(html).to have_tag('a', :with => {'data-remote' => 'true', 'data-method' => 'post'})
    end

    it 'supports nested attributes' do
      html = tag(:div, :data => {:dojo => {:type => 'dijit.form.TextBox', :props => 'readOnly: true'}})
      expect(html).to have_tag('div', :with => {'data-dojo-type' => 'dijit.form.TextBox', 'data-dojo-props' => 'readOnly: true'})
    end

    it 'supports open tags' do
      html = tag(:p, { :class => 'demo' }, true)
      expect("<p class=\"demo\">").to eq html
    end

    it 'escapes html' do
      html = tag(:br, :class => 'Example <foo> & "bar"')
      expect("<br class=\"Example &lt;foo&gt; &amp; &quot;bar&quot;\" />").to eq html
    end
  end

  describe '#content_tag' do
    it 'supports tags with content as parameter' do
      html = content_tag(:p, "Demo", :class => 'large', :id => 'thing')
      expect(html).to have_tag('p.large#thing', :text => "Demo")
    end

    it 'supports tags with content as block' do
      html = content_tag(:p, :class => 'large', :id => 'star') { "Demo" }
      expect(html).to have_tag('p.large#star', :text => "Demo")
    end

    it 'escapes non-html-safe content' do
      html = content_tag(:p, :class => 'large', :id => 'star') { "<>" }
      expect(html).to have_tag('p.large#star')
      expect("<p class=\"large\" id=\"star\">&lt;&gt;</p>").to eq html
    end

    it 'does not escape html-safe content' do
      html = content_tag(:p, :class => 'large', :id => 'star') { "<>" }
      expect(html).to have_tag('p.large#star', :text => "<>")
    end

    it 'converts to a string if the content is not a string' do
      html = content_tag(:p, 97)
      expect(html).to have_tag('p', :text => "97")
    end
  end
end
