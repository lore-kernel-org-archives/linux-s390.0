Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="ciBv2Hz4"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490CB9;
	Wed, 13 Dec 2023 07:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWaulL28VbIDxZRKcQHXPKjpYov/UCQGUPmwzgr3UDSTdWxHW4KlUxU2MXNJIp8BhxIfCWH8/BVNLLYPGmcQ+Vih/6rm1xi21IaaU7H2WTvI1CEYYMFnSAhv5PTzKleyy5RLbfMHUuOpbDwgAMqTUVZUgof5mocbUuLSckIB1g7mQL//CCGxwfAi76q+o8xdMd1u9NfpPfkdKvTAs4B4Y1CJwTpxEvGMHMZrDBIRQFQ7JHjUtdO2j5t+QekY2KkdYwZ9dUBhaOvJ8/poixhMPGgYSQTJDDEAiGzU/AHmYfAjPSr3q4q4NU0ARv47OeXavIbFe6eVSBLq1avOtX7inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S37GUf9oR04B/7e61aiB7bXsNCEc4+orQHNpWrM2pSw=;
 b=Wy5vLNVak/ZifIHsDgzIonXK3JlXF9HZTlT5JvqIyPoGvNgYjvgVVHrgkVlVM+tqPcebWszNl9vzsC9lphTN/Uu6QInACOmJI4xPdUeyg/NrEjR8NlNDA2oRSPA4fQB7vCoXKmlUzKHgushanocriptUj6MIiLPyQPw+UzVoOdc0qZLv6rIPrW84A6QbRumBrBcyCSUEbXs0tRkl5Ak8luUiIOK6IN112qpQT4u3mQoV0UagQ0P2BShMPEYM2bGpu1Fea+NAmE8DEZiNCLk+c6FsyhB0+QWEGeQtQICowcLjP7qGZUWl4Lgt2ml7TnP4r7IfJWlJc3CjQQBTrwp3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S37GUf9oR04B/7e61aiB7bXsNCEc4+orQHNpWrM2pSw=;
 b=ciBv2Hz4wvKtGIKwEvjTBTGSF2JbZdBBDLe7xZ8Ly+4Vt8c2Ov51Os/sw4s6iGZqPhqxW1Hi4eDWkkX5owLJIkC4KV5Nan5CTkfQTGWyE7ceEGn3iHZXBqX36GeJNO3LfB/IYxASZwhoJiKWccXiRcZxJs9ja2N83vTAgVqZP7m6pvlw0isuFvgC0Iud43db+g23cJ5lYvdqRvUE3jkQxwU7++L/3k3E0fShLb1BoshawsV3IFP16kbGWjM5h0NFkXdorVFCQlUfK/RE3FNb4UexK/ysGM/GHCsXrJW50Qv5AdZg55DwSbcc9bOtN79lAArL0S/tCB73IIHufNwPDw==
Received: from PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::19)
 by DB4PR10MB6309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:52:05 +0000
Received: from PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3324:67b5:be4b:855d]) by PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3324:67b5:be4b:855d%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:52:05 +0000
From: "Nikolaou Alexandros (SO/PAF1-Mb)" <Alexandros.Nikolaou@de.bosch.com>
To: Wen Gu <guwen@linux.alibaba.com>, Gerd Bayer <gbayer@linux.ibm.com>, "D .
 Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Nils
 Hoppmann <niho@linux.ibm.com>
CC: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, netdev
	<netdev@vger.kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: SMC-R throughput drops for specific message sizes
Thread-Topic: SMC-R throughput drops for specific message sizes
Thread-Index: AQHaLdxR+aGORF3yeUam3+BSd72rrA==
Date: Wed, 13 Dec 2023 15:52:05 +0000
Message-ID:
 <PAWPR10MB7270AF8BCFB5B9D766D15A84C08DA@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR10MB7270:EE_|DB4PR10MB6309:EE_
x-ms-office365-filtering-correlation-id: 9ec9bcc9-f94c-46cb-bff6-08dbfbf3747e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MK5UN9NVH8rwNTERhhCOJU2AP5VssqZa2Zm3WtiMQ0RG8s2hHT08POQxwfOzsa3fdMrZQbSHgxB3ZFFHHvlZBFmlKAQGieulm5E/u6Fr+ot0UAOCWj68gpG8d/RYTDEFawC8dbUkw9zw3RckuV4WLeHXCyU2r2syCm8e77uUWcq0WLRCL0FEVVvGy/ItiIiA9C4BZpZuX4lp6b4/ojos68eNf9OyaFnw8sS1t0G7e61UmIg4zOnnRbQuiYnbC1nVdbLYDxzeZQ2Xw5UtCNaeAnhbsZO8ZqW3WALxOKpcpIpB2Xa7PQ/16U+gQ0dQHf5hFM9zcQqWhX/RoMxtl9hf/KSSw0RfmTZIKmWSHFgjjdcpsNALEz94YkxEhbaqT32CUaHJgWfsTiGdgqRFo+I8DVUK49g/BjD7dIR5aGab14bs0A7ELxnG8r7MTarSQPIhysM+tY8REuxfvf3l+k1I05nwmtd8SxPlt9HpDcp4gwmZptp8Bm1n5F5WVyffCoOwwt9HLCvEXvI6cPpMGKL6H4bXxekibEpg3ic9jB6w08H85E4+1429L/OnGOHtXlpJCs0kq4RmKqzJlyE/9gzvooaSds6fivwWR1hRL1NW29c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(71200400001)(26005)(66574015)(38100700002)(52536014)(122000001)(8936002)(316002)(54906003)(7416002)(64756008)(8676002)(2906002)(5660300002)(4326008)(15650500001)(66446008)(66476007)(478600001)(53546011)(41300700001)(9686003)(66556008)(76116006)(110136005)(91956017)(7696005)(66946007)(6506007)(82960400001)(38070700009)(86362001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?0H0EwUbhubC5ul6GgtFE2NCuKktqqqOBDxL4neCwjQZuVkpqkdEXUAaj?=
 =?Windows-1252?Q?wwyyakJ7Iu4iLfpnRdulgUVI3nWhvHepxL2M3TKigshWNDn2/50ByWtK?=
 =?Windows-1252?Q?qVTeI1wd+c2ojM9XrS1jTjG9IIs/70GWkQ117Phz94XO39r7fuzZcjmt?=
 =?Windows-1252?Q?qLbridOum8FZNTb6Z1G3AmvPTDAp7qNwsYeg4N7yXiLRc1XK1D0x9lij?=
 =?Windows-1252?Q?lFzvHEdKXNi5Cjcultb4f2xttWhPhfOkrimBPfsFgcUQlxAzNlOtSyjB?=
 =?Windows-1252?Q?WOiPg1w9y7tL0xB5qLJz4866Rk8tiA8O+EN5teSlCvzth/ZNosCaeY/2?=
 =?Windows-1252?Q?ZDf7kzCVQKvRNWwomzVc2ud7ZqZy38Bjb4Qm1lheVh+6W+PpqKbL+X3+?=
 =?Windows-1252?Q?yLoRNOC2UwAfngLCFz2X3IsJ1m82hhGv4Zio9EK98IUkcCfa4q5TT/j7?=
 =?Windows-1252?Q?3SqDqZq3LVEahXdvi/Dyx0Amp93d+uouhgfBlch5uK0ZSu7lNFrEWDWP?=
 =?Windows-1252?Q?5AUoSXFCEpfZnuxpwoGhs6f77GqBAZP5WTSm2BIaTrI+U9L+O6ir194H?=
 =?Windows-1252?Q?ioGj7j5zX2Qb/rarqUT/in3m0oZnb4ht1bf1LmKw82p/eY9f/e2p98BR?=
 =?Windows-1252?Q?v6YeBzpP7rNqpYoahIpB3gPNbjG+ye/JCIf/wO3IrJrTCTKEeCnyAsMv?=
 =?Windows-1252?Q?zqyOO9anZfEYvy7VwNaJQiin8HlUta+5amYv3WL39CBkBZS56lIdbKPH?=
 =?Windows-1252?Q?Cb3IeW5YENzGsU4n8rYiUAKd3us5y/4zOdnxpAakOIHMJgh53AfArpbP?=
 =?Windows-1252?Q?j1t7lQ1nI3TG9ffyKu4IxsBLus2y2q20XhPy8tcbWW1Pjl/+Cxq9iH8W?=
 =?Windows-1252?Q?ga6DC2kMrCv24fUDuJzsXA+K9Go9Mg6r1zgjtyi+3Uk3YnthoUzq7puA?=
 =?Windows-1252?Q?POqssrexYrKFRzELMdsyInPFWPnDMkcaTfDsvEiyeVzshccL4ZOFivqq?=
 =?Windows-1252?Q?AL92v0cO0D1nVuBXJkc6nt306/xBZLfMtJ3v0ZvPYEiDqt/S7Ml334LQ?=
 =?Windows-1252?Q?Q6JoCF4Z/EvwXhd/MtafUcvKH6W/AEKHiqIa0EBeFrSHeTR5e0IdOZLy?=
 =?Windows-1252?Q?k7BndgkG8XmtTQF0ZfBTfpM787UVvg5E3eFa+Y1OtG7LoIYtEnL8MdgY?=
 =?Windows-1252?Q?NdciwYoso6wxzNgqHO56PjCCQi7fAIS/lmMKtzF7J1jTU2gXvJ0RIudT?=
 =?Windows-1252?Q?tw+/g00gs4G/5BnE4d6QL8EdL7L6SkfO2PHtpfurs8g+3GwLxeAClEiJ?=
 =?Windows-1252?Q?v9zneqZ5bzKF1j5ClmcKgrsPQNqAm58HxP71pB/NXQGNxuHVf1VkoNmj?=
 =?Windows-1252?Q?sjhe5N3zF8yJl4FBWknGRgf4cwR/k0fKdyU8oYMYn7rjxgaVoOyIgfDR?=
 =?Windows-1252?Q?R9VRwXDgC2jOHcj9XT4oFSLqRQp67WCpvoEwQP81EE2uufMBWCnXRAYX?=
 =?Windows-1252?Q?WPp8KWDeDNH0sA5lskPZDyRewaWMHfJPN8U/itBLKnRIMd+KvbE/bahr?=
 =?Windows-1252?Q?7Z6VerFWXy27oMopXPpZyaC95E+CJhczpGqHp+FHxv8q+F5D0H6audLv?=
 =?Windows-1252?Q?pLZN4PETC6YaWlHTcEggh9OyBuU1ReinzWhjDGAFmWF2mD8WMHhaSVR5?=
 =?Windows-1252?Q?zkVLuBlIMBA=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec9bcc9-f94c-46cb-bff6-08dbfbf3747e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 15:52:05.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtz/GRmVAyg9y+GcnqZMtvQbO+1zVkdpuFywhEiFojDtB9x3vzLFpGWioz8411yih/UTy4tlxQUKNm0qkQ3n/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6309

Dear Gerd,=0A=
=0A=
Thank you for directing this matter to the most relevant group and =0A=
individuals. Your support is greatly appreciated. We're actively delving de=
eper into the issue to gain further insights as well.=0A=
I'll ensure to keep this thread updated with any new findings as we progres=
s.=A0=0A=
Should you need any additional information, please feel free to reach out.=
=0A=
=0A=
Mit freundlichen Gr=FC=DFen / Best regards=0A=
=0A=
Alexandros Nikolaou=0A=
=0A=
=0A=
Bosch Service Solutions Magdeburg GmbH | Otto-von-Guericke-Str. 13 | 39104 =
Magdeburg | GERMANY | [www.boschservicesolutions.com]www.boschservicesoluti=
ons.com=0A=
Alexandros.Nikolaou@de.bosch.com=0A=
=0A=
=0A=
Sitz: Magdeburg, Registergericht: Amtsgericht Stendal, HRB 24039=0A=
=0A=
Gesch=E4ftsf=FChrung: Robert Mulatz, Daniel Meyer=0A=
=0A=
From:=A0Wen Gu <guwen@linux.alibaba.com>=0A=
Sent:=A0Wednesday, December 13, 2023 14:38=0A=
To:=A0Gerd Bayer <gbayer@linux.ibm.com>; Nikolaou Alexandros (SO/PAF1-Mb) <=
Alexandros.Nikolaou@de.bosch.com>; D . Wythe <alibuda@linux.alibaba.com>; T=
ony Lu <tonylu@linux.alibaba.com>; Nils Hoppmann <niho@linux.ibm.com>=0A=
Cc:=A0linux-s390@vger.kernel.org <linux-s390@vger.kernel.org>; netdev <netd=
ev@vger.kernel.org>; Wenjia Zhang <wenjia@linux.ibm.com>; Jan Karcher <jaka=
@linux.ibm.com>; Dust Li <dust.li@linux.alibaba.com>=0A=
Subject:=A0Re: SMC-R throughput drops for specific message sizes=0A=
=A0=0A=
=0A=
=0A=
On 2023/12/13 20:17, Gerd Bayer wrote:=0A=
> Hi Nikolaou,=0A=
>=0A=
> thank you for providing more details about your setup.=0A=
>=0A=
> On Wed, 2023-12-06 at 15:28 +0000, Nikolaou Alexandros (SO/PAF1-Mb)=0A=
> wrote:=0A=
>> Dear Wenjia,=0A=
>=0A=
> while Wenjia is out, I'm writing primarily to getting some more folks'=0A=
> attention to this topic. Furthermore, I'm moving the discussion to the=0A=
> netdev mailing list where SMC discussions usually take place.=0A=
>=0A=
>> Thanks for getting back to me. Some further details on the=0A=
>> experiments are:=0A=
>>=A0=A0=0A=
>> - The tests had been conducted on a one-to-one connection between two=0A=
>> Mellanox-powered (mlx5, ConnectX-5) PCs.=0A=
>> - Attached you may find the client log of the qperf=A0output. You may=0A=
>> notice that for the majority of=A0message size values, the bandwidth is=
=0A=
>> around 3.2GB/s=A0which matches the maximum throughput of the=0A=
>> mellanox=A0NICs.=0A=
>> According to a periodic regular pattern though, with the first=0A=
>> occurring=A0at a message size of 473616 =96 522192 (with a step of=0A=
>> 12144kB),=A0the 3.2GB/s throughput drops substantially. The=0A=
>> corresponding commands for these drops are=0A=
>> server: smc_run=A0qperf=0A=
>> client:=A0smc_run=A0qperf=A0-v -uu=A0-H worker1 -m 473616 tcp_bw=0A=
>> - Our smc=A0version (3E92E1460DA96BE2B2DDC2F, smc-tools-1.2.2) does not=
=0A=
>> provide us with the smcr=A0info, smc_rnics=A0-a=A0and smcr=A0-d=0A=
>> stats=A0commands. As an alternative, you may also find attached the=0A=
>> output of ibv_devinfo=A0-v.=0A=
>> - Buffer size:=0A=
>> sudo=A0sysctl=A0-w net.ipv4.tcp_rmem=3D"4096 1048576 6291456"=0A=
>> sudo=A0sysctl=A0-w net.ipv4.tcp_wmem=3D"4096 1048576 6291456"=0A=
>> - MTU size: 9000=0A=
>>=A0=A0=0A=
>> Should you require further information, please let me know.=0A=
>=0A=
> Wenjia and I belong to a group of Linux on Z developers that maintains=0A=
> the SMC protocol on s390 mainframe systems. Nils Hoppmann is our expert=
=0A=
> for performance and might be able to shed some light on his experiences=
=0A=
> with throughput drops for particular SMC message sizes. Our experience=0A=
> is heavily biased towards IBM Z systems, though - with their distinct=0A=
> cache and PCI root-complex hardware designs.=0A=
>=0A=
> Over the last few years there's a group around D. Wythe, Wen Gu and=0A=
> Tony Lu who adopted and extended the SMC protocol for use-cases on x86=0A=
> architectures. I address them here explicitly, soliciting feedback on=0A=
> their experiences.=0A=
=0A=
Certainly. Our team will take a closer look into this matter as well.=0A=
We intend to review the thread thoroughly and conduct an analysis within=0A=
our environment. Updates and feedback will be provided in this thread.=0A=
=0A=
>=0A=
> All in all there are several moving parts involved here, that could=0A=
> play a role:=0A=
> - firmware level of your Mellanox/NVidia NICs,=0A=
> - platform specific hardware designs re. cache and root-complexes,=0A=
> interrupt distribution, ...=0A=
> - exact code level of the device drivers and the SMC protocol=0A=
>=0A=
> This is just a heads-up, that there may be requests to try things with=0A=
> newer code levels ;)=0A=
>=0A=
> Thank you,=0A=
> Gerd=0A=
>=0A=
> --=0A=
> Gerd Bayer=0A=
> Linux on IBM Z Development - IBM Germany R&D=
