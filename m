Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC9ECAAD8
	for <linux-s390@archiver.kernel.org>; Wed, 21 Sep 2022 07:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIUHHN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Sep 2022 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIUHHL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Sep 2022 03:07:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DF681B2A;
        Wed, 21 Sep 2022 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663744029; x=1695280029;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZFKuBqIQG4S4ysmFPSQ50SNbieQfRjFWIjJjwyWLnnM=;
  b=QcW53NdHo2NVyoIZYKTSm2VD5CE9+01W45A9apprM/0e0FydBriiusuM
   i4v+oufc+oFbS06wvafLV5/lUA7ftWaWD6kp7K06ktUQFf8E1yGoxoGQv
   +SFPq4n9DE+hG8S6c2xKqDUHID0bFuE0PdCsnYBYP5MA59pZmXwM5KvAz
   hIHS+w0vKcVSDV1s7oVjC+1EejEB1l05PPKsTf0KZ4pYV1mccyL5abyMR
   JOVQH2FfNvYnPzyt4htwqefWc2snBybDR6RGodJVrOMT9RRV1rFIb9HDz
   va3YDBpoKQz/DeZcMzpL1QIqf4aQQRKuokDUjqhYpghXzGJUwTE+IkrvZ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="212323808"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 15:07:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/O9M/uig0Yd9BW58lrsz8IYvGqDtWCD/8I1Z0NRogv75r6bBd5WwMItXJaDPcbJ++JuSoci+SJGObIVwRXSlColw0kP50hIbC6cLcnkkC9QIwOUZ6DGG2EC/12o9O5fA7wuTgKCyZ8qWxzUA+z8LcI5XECfkej8u48ymVyn+OM5Sv6hFPaVFCTNm/uxPBkU9rVGNhGKfdiwrAUBcEX1dmEy7Wfz+OzoAEgGFtE4PvUjQRBvC/AxebIGf4f9UzDXkf/3HR04uEj+QXQZRmuTreIOC4+dthWkJVY4bm3cYO04/BrZmGO3gXhsy7GlwKFiwsLpaemHdEhl9uHTf+/keQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0ynvi2pITQ+lqR5p0jtxT2ExfHJ2MkkR+KMOizK5jM=;
 b=X7LaIJem1lasvEhdNuEGiR5bsX5KQZLDDLl00kngJgwAIScDNMpGqKDdtpAF4X8xxgYlfTFpS95s9LFK9s4324EWSbfVXDc/GJLm885CQmQurW/Fpxh6txMYlhrvU2YqWxklmEhKM/xfjmm3PbgouHPT7jKlowUltNkAOhfUOKdfUQODwaZ2fsIzfsf8cIHf/Doa2i0EXRgWsW1q8TXFcrWs+4kQJUmPdNRKlDlw8A+DGo1FV95qdjTBQ99BgR3zdxIwaAywDUWcBSHP/CTiJNLmOtI5WVrtLqfgGslk66JVooFSDglMXXop9SAQle38skOnrDPmcFF9f/axg+FarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0ynvi2pITQ+lqR5p0jtxT2ExfHJ2MkkR+KMOizK5jM=;
 b=iSW0Qy/q3j0ffz97oJm1lxYVnP1JSM28+40lggDmVAiNu4yKaOwTAWBf86bw8eTyQmK72gddbItGt30yO0/U/JyqoAsVlz4YjVV2kEdTbzJThVmM/m0S97usdlc5EASYte+dFVkO0XZd4O4PqLmvk9AQegOZi7lwyDYj1iV1h7c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4497.namprd04.prod.outlook.com (2603:10b6:208:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 07:07:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 07:07:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Stefan Haberland <sth@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/7] s390/dasd: add hardware copy relation
Thread-Topic: [PATCH 0/7] s390/dasd: add hardware copy relation
Thread-Index: AQHYzSbvRFnNxI0ylUmg0mlszeTnMA==
Date:   Wed, 21 Sep 2022 07:07:05 +0000
Message-ID: <PH0PR04MB741609C789F6A801747A64759B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4497:EE_
x-ms-office365-filtering-correlation-id: 07405fe1-42c6-4a73-2e25-08da9b9fe421
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhwHQtb1gl32jw8d7wsepF4LwecJy0XIx6ncjfpigGo3q2cpJWptvr1FwlyOMC/Z/SldCgmU5Leq0VQchGwQiJ90UwEFPytlXQyJM+1BLYrb1G5JBeCYJ6Ye5WhvLoIE3ZKYp/q+1Djx4J0ce4S3VrEBIlEdonzQbDjhOkjYv97gLVkzcNBbYfhjLTojnapOivMMT3c7lW89grmLIIc9L7yWn7KltmBYVjdFYvBwmbWF+eJ8pHpWi2xeDTQLVrP0aJCG3zEX6hFmzzdhqlCzQZw78VHh3gWXkAZVeuT7RNQ9HcFLTcPjO5LmbAnWMHXcA/DQeNoltW+lt3zKZ4FgskjhLPg05OyE24lN1IfKy5jpvFY+dBjr5RxGeptJ5+v+C7FNn+DsngbHKnzKKjY2LSjavmm0K9U5xqVzx2uWnHx7E7nvjM/UoHiP8Z2RpZ04CpoNkeOLs0IMNKKQeUVOt629ZYXFxaXXidUrf6861vkHIuFgCGVX87nZ7O6BKUC7ikUSGV8diZPVsLknZfURBlL7DDlj4fVM6xpVZSt41js3uF7oBWWA2gm7HVxB06HIYSA0kktsii8yoanLNMZGoty88HVOLFqldojsyOC1XvavdUeD1EdheqBjnyoM+qlBb13vDB9k6Zv70/N87XNBMPN8NQOQTBwApP2mWrpcuko39x6lESBwy+RqrXTl7Nt5hDhw8v+Q5hS1JhRIym5v5VL1HCya9Z8EvnRJTDRMFWesHAzRe9PmdSSF4izmDiuDtwlLnc26NBLDrbqajR9okg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(83380400001)(82960400001)(4744005)(122000001)(38100700002)(38070700005)(64756008)(5660300002)(2906002)(41300700001)(8936002)(52536014)(55016003)(186003)(53546011)(478600001)(71200400001)(6506007)(7696005)(9686003)(8676002)(4326008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(54906003)(110136005)(33656002)(91956017)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M/0QSVOjsZcONQDWRnZTbpNTKNnWAa78kH63I24ooqSNSFX43L5n6XODCIir?=
 =?us-ascii?Q?QEONZfuqfcaMo1050kjRrs3io6C7iOolygDLAIZDTxGDXe08mbItT5wAkIVW?=
 =?us-ascii?Q?BR4gXOLLK9ZLH5gSsps6d4+zFtftMOjlwE2sSwwCdvHeZhWH0OBXI0oqoD2i?=
 =?us-ascii?Q?I8ULce2ECNRUX8d4Hr3ohH0eASw8T4ywTdFfjZQfDdVNI5OT60i7nD+XiInd?=
 =?us-ascii?Q?xL227BMzia2Www/sk9rwK3PzhgaSw00gl3aK2ilFT8uZeOFm78WsbrI968UU?=
 =?us-ascii?Q?wJgoBF8QjpI664g0YGTCO/rzVvKwQJgAMXUF3xqkk6dqT9RoW/dQEYByHo47?=
 =?us-ascii?Q?6zONxJeEm8I9YJ4L2IzvIhh4/QfvECx8xhqgN9G2/kWnXUtvgycb3nX1w7uX?=
 =?us-ascii?Q?KDukehJxK3T5UsTXqm0izFS3Zk30wr0Q0tyW6cJm9IfMpl7cHm/a1jLcvD3H?=
 =?us-ascii?Q?ThctP8KrZmwD0vSAGDPtf5BGv/SG0w/UP/EMrZwUAS3S3Ul7YXE0iCM3Hl3n?=
 =?us-ascii?Q?ake1iTlXrVouEflU7rWeo05kDDOgjmmVP7J41hy/45IbEXZupAIeKw1RVwGo?=
 =?us-ascii?Q?ucWCgmM48aYw9cVa2bg/pK17dxaB1qMAI2k0NzgZAYRHTuxGR2DOTtfbnci0?=
 =?us-ascii?Q?o020Bw0OO2fiYjH9bb+1SImgi5Q4Dj65eicCoNSrm+0IX5uHRUQBvMGYd8/f?=
 =?us-ascii?Q?NmIiVbbAvpvm3Jwk7MqAiwAu5Z4H4Gt3uMLDZUHCu91vRmceiYVpgcX0hXGn?=
 =?us-ascii?Q?3QcdKVbh4iHvTWBvR8iW9LD4qKDwYSdkxC+biZlexpfrjXcalXT9SE1kwrZj?=
 =?us-ascii?Q?2l9PiHbN9sX6/5bHLGP/m9UTrFpZVtrXxqHO0XPwwsNy0MGSSSksu7O7c4Vt?=
 =?us-ascii?Q?1L9qNWW3ZtaUDmqW/pIhU61c3d5PEDgCp11fNRo7KXtPyKU36lEBoYfGHV37?=
 =?us-ascii?Q?QyFXLNXCUByU2uTwKZbxTlq1fY8tMj3uCmmZu25e9ifnWw19TLvMgKdZrMwV?=
 =?us-ascii?Q?ET/ROi223nqZz6i30TAFMrBuQlqwvm3LfKO3UPdpkJUEek853s6o5WOf+jjZ?=
 =?us-ascii?Q?qGv6gSpMqd6dTgJE0oGssMv7m74GPHaEn8/vKedwp6aaefPtXG6QdUoH13QR?=
 =?us-ascii?Q?ftFQW8oU9q4xr7wl2a7iyPeMwptXVEDzR32AKB2ZTqUg8pQvaa+IV+Df5X7C?=
 =?us-ascii?Q?nVo1StTpCECnAsRa3My0qcLAmxTKa6mFdR1wZ0J5FxVKHd8ilOa+2T7Du3/W?=
 =?us-ascii?Q?j2LumuF0FEhezY94s7PKK/IHKyCV12YbF8ZHXToTiXJOCktyh3vSvHLfuZJU?=
 =?us-ascii?Q?yuCIel5XrFhwr6PX+uwxNrtXLCndAnKZiBRzq7gPti5eoCIl/b7GynaV3huj?=
 =?us-ascii?Q?vWCZgxbhyBC3Yv4E+vtuiWNN1urK00TKVSqfeVanrK/JsEl3gs7v7mdBDgr4?=
 =?us-ascii?Q?rux0FoE7xaCuqG3CqY+kk7NEu1pmLvTFyVHSYovhCA9cIyJnYwi71vlmXvQ6?=
 =?us-ascii?Q?9fWYPmMEzW1Nyq/+AIHV1umvt9sgL4VwCXe0rKpKPGtk+IuGw/qDBjx39Apg?=
 =?us-ascii?Q?Z7VZHdh9c8m58QQp9HDMoPEdHTwX1fjPAwZcwuwj8i+sTbBXwtzwmMs8eVtE?=
 =?us-ascii?Q?Kq6mHns6Vi8W/fS22n5MR53k7MGyd17TdwPzYvjRdyq4zTCQ/RF9yqxq2dh2?=
 =?us-ascii?Q?IS86Ag0Edq6d4anI+DPjT+3jwrY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07405fe1-42c6-4a73-2e25-08da9b9fe421
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 07:07:05.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8gml9nS/vMnCs0IVQXqSWW0HoY7vuvZgOYzTv2bV0+7QuZ0ERtaBg8S1Q+paKdiNUxmA5oC/XUGvpmhV+WLYK/0yIN+lCFA6+Hn+rqMcOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4497
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20.09.22 21:26, Stefan Haberland wrote:=0A=
> Hi Jens,=0A=
> =0A=
> please apply the following patchset to for-next.=0A=
> It adds basic support for a harwdare based copy relation to the DASD=0A=
> device driver.=0A=
=0A=
Hi Stefan,=0A=
=0A=
How's the relation of this patchset to the current efforts of getting a com=
mon=0A=
copy offload API (NVMe Simple Copy and SCSI XCOPY) into the block-layer?=0A=
=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
