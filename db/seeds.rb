me = FactoryGirl.create(:user, :fake,
  name: "Steve Richert",
  username: "steve",
  password: "secret"
)

FactoryGirl.create_list(:message, 12, :fake, recipient: me)
