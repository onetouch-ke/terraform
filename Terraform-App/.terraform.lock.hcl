# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/gavinbunney/kubectl" {
  version     = "1.14.0"
  constraints = "~> 1.14.0"
  hashes = [
    "h1:Ck8Re/28x7VBI5ArFg0VSg1woPu/APm1ZbMuzqUdnPo=",
    "h1:iNdaB+j0xQtWLbyN2CC936r/wbSGSU345JKi0dArAhA=",
    "zh:0350f3122ff711984bbc36f6093c1fe19043173fad5a904bce27f86afe3cc858",
    "zh:07ca36c7aa7533e8325b38232c77c04d6ef1081cb0bac9d56e8ccd51f12f2030",
    "zh:0c351afd91d9e994a71fe64bbd1662d0024006b3493bb61d46c23ea3e42a7cf5",
    "zh:39f1a0aa1d589a7e815b62b5aa11041040903b061672c4cfc7de38622866cbc4",
    "zh:428d3a321043b78e23c91a8d641f2d08d6b97f74c195c654f04d2c455e017de5",
    "zh:4baf5b1de2dfe9968cc0f57fd4be5a741deb5b34ee0989519267697af5f3eee5",
    "zh:6131a927f9dffa014ab5ca5364ac965fe9b19830d2bbf916a5b2865b956fdfcf",
    "zh:c62e0c9fd052cbf68c5c2612af4f6408c61c7e37b615dc347918d2442dd05e93",
    "zh:f0beffd7ce78f49ead612e4b1aefb7cb6a461d040428f514f4f9cc4e5698ac65",
  ]
}

provider "registry.terraform.io/hashicorp/aws" {
  version     = "5.100.0"
  constraints = "~> 5.0"
  hashes = [
    "h1:H3mU/7URhP0uCRGK8jeQRKxx2XFzEqLiOq/L2Bbiaxs=",
    "h1:lcDxx0Nx+ifFqTBpxz8Un27O0s+I7UNJAr/rUpSqlig=",
    "zh:054b8dd49f0549c9a7cc27d159e45327b7b65cf404da5e5a20da154b90b8a644",
    "zh:0b97bf8d5e03d15d83cc40b0530a1f84b459354939ba6f135a0086c20ebbe6b2",
    "zh:1589a2266af699cbd5d80737a0fe02e54ec9cf2ca54e7e00ac51c7359056f274",
    "zh:6330766f1d85f01ae6ea90d1b214b8b74cc8c1badc4696b165b36ddd4cc15f7b",
    "zh:7c8c2e30d8e55291b86fcb64bdf6c25489d538688545eb48fd74ad622e5d3862",
    "zh:99b1003bd9bd32ee323544da897148f46a527f622dc3971af63ea3e251596342",
    "zh:9b12af85486a96aedd8d7984b0ff811a4b42e3d88dad1a3fb4c0b580d04fa425",
    "zh:9f8b909d3ec50ade83c8062290378b1ec553edef6a447c56dadc01a99f4eaa93",
    "zh:aaef921ff9aabaf8b1869a86d692ebd24fbd4e12c21205034bb679b9caf883a2",
    "zh:ac882313207aba00dd5a76dbd572a0ddc818bb9cbf5c9d61b28fe30efaec951e",
    "zh:bb64e8aff37becab373a1a0cc1080990785304141af42ed6aa3dd4913b000421",
    "zh:dfe495f6621df5540d9c92ad40b8067376350b005c637ea6efac5dc15028add4",
    "zh:f0ddf0eaf052766cfe09dea8200a946519f653c384ab4336e2a4a64fdd6310e9",
    "zh:f1b7e684f4c7ae1eed272b6de7d2049bb87a0275cb04dbb7cda6636f600699c9",
    "zh:ff461571e3f233699bf690db319dfe46aec75e58726636a0d97dd9ac6e32fb70",
  ]
}

provider "registry.terraform.io/hashicorp/helm" {
  version     = "2.17.0"
  constraints = ">= 2.11.0, < 3.0.0"
  hashes = [
    "h1:UXXOgqsqALJFmxAQ3BQcSLJxNcn7qgzEH/P3FEqNkCU=",
    "h1:rsqAO9oKyDMLiysQqrWEzf9CNtU9NJtwEGk7bSItC9g=",
    "zh:06fb4e9932f0afc1904d2279e6e99353c2ddac0d765305ce90519af410706bd4",
    "zh:104eccfc781fc868da3c7fec4385ad14ed183eb985c96331a1a937ac79c2d1a7",
    "zh:129345c82359837bb3f0070ce4891ec232697052f7d5ccf61d43d818912cf5f3",
    "zh:3956187ec239f4045975b35e8c30741f701aa494c386aaa04ebabffe7749f81c",
    "zh:66a9686d92a6b3ec43de3ca3fde60ef3d89fb76259ed3313ca4eb9bb8c13b7dd",
    "zh:88644260090aa621e7e8083585c468c8dd5e09a3c01a432fb05da5c4623af940",
    "zh:a248f650d174a883b32c5b94f9e725f4057e623b00f171936dcdcc840fad0b3e",
    "zh:aa498c1f1ab93be5c8fbf6d48af51dc6ef0f10b2ea88d67bcb9f02d1d80d3930",
    "zh:bf01e0f2ec2468c53596e027d376532a2d30feb72b0b5b810334d043109ae32f",
    "zh:c46fa84cc8388e5ca87eb575a534ebcf68819c5a5724142998b487cb11246654",
    "zh:d0c0f15ffc115c0965cbfe5c81f18c2e114113e7a1e6829f6bfd879ce5744fbb",
    "zh:f569b65999264a9416862bca5cd2a6177d94ccb0424f3a4ef424428912b9cb3c",
  ]
}

provider "registry.terraform.io/hashicorp/kubernetes" {
  version = "2.37.1"
  hashes = [
    "h1:SsrLjpsD9rltZmr24CBiAB3TAMmJ0SyplBh8oyAr/qQ=",
    "h1:okZwE5tiivdUNTXdJyN01Mmzt13WU+kV5/qjyj7RhKw=",
    "zh:0ed097413c7fc804479e325966886b405dc0b75ad2b4f54ce4df1d8e4802b397",
    "zh:17dcf4a685a00d2d048671124e8a1a8e836b58ecd2ef628a1c666fe0ced2e598",
    "zh:36891284e5bced57c438f12d0b27856b0d4b70b562bd200b01919a6a89545be9",
    "zh:3e49d86b508e641ba122d1b0af24cdc4d8ffa2ec1b30022436fb1d7c6ba696ea",
    "zh:40be623e116708bdcb0fac32989db43720f031c5fe9a4dc63395078185d24403",
    "zh:44fc0ac3bc39e289b67f9dde7ee9fef29eb8192197e5e68fee69098573021722",
    "zh:957aa451573bcde5d57f6f8338ea3139010c7f61fefe8f6a140a8c267f056511",
    "zh:c55fd85b7e8acaac17e30670ac3574b88b3530820dd004bcd2a5daa8624a46e9",
    "zh:c743f06843a1f5ecde2b8ef639f4d3db654a334ef248dee57261c719ea843f3a",
    "zh:c93cc71c64b838d89522ac5fb60f68e0e1e7f2fc39db6b0ead7afd78795e79ed",
    "zh:eda1163c2266905adc54bc78cc3e7b606a164fbc6b59be607db933b302015ccd",
    "zh:f569b65999264a9416862bca5cd2a6177d94ccb0424f3a4ef424428912b9cb3c",
  ]
}
