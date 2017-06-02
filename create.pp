ec2_instance { 'Puppet-Client-1':
  ensure            => present,
  region            => 'ap-south-1',
  availability_zone => 'ap-south-1a',
  subnet            => 'subnet-a3e2a7ca',
  image_id          => 'ami-83a8dbec',
  instance_type     => 't2.micro',
  monitoring        => false,
  key_name          => 'ubuntu',
  iam_instance_profile_name	=> 'Administrator',
  security_groups   => ['PuppetMaster'],
  user_data         => template('/home/ubuntu/setup.sh'),
  tags              => {
  tag_name => 'puppet',
  },
}
