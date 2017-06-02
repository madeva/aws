ec2_instance { 'Puppet-Client-1':
  ensure            => present,
  region            => 'ap-south-1',
  availability_zone => 'ap-south-1a',
  subnet            => 'subnet-e6118a8f',
  image_id          => 'ami-c2ee9dad',
  instance_type     => 't2.micro',
  monitoring        => false,
  key_name          => 'ubuntu',
  iam_instance_profile_name	=> 'S3_Access',
  security_groups   => ['sudi'],
  user_data         => template('/home/ubuntu/setup.sh'),
  tags              => {
  tag_name => 'test',
  },
}