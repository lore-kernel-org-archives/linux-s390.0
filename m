Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF52C32771
	for <linux-s390@archiver.kernel.org>; Wed, 21 Sep 2022 11:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIULLc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIULLb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Sep 2022 07:11:31 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D838B2D6;
        Wed, 21 Sep 2022 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663758690; x=1695294690;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rmmRXpIlz4xMeltC0qG4Wd69D2Eyq/Ia4zCV1JugqJ4=;
  b=XR4GnptzWbWWPHtVitGBAhrWj4hDiA13KdDwUFx9qyV9BzBTtilC0rIV
   cmt68cCoK2+e5hNOyD1kI/bKsAJXoTe4GIAPezNvRczvEbAsr0AYyPbkL
   QJMhgkSRlpnbAbvDFo3vTcjWUNk+6K/lKy6COfzh0dRybY1ZsVCACOyS9
   tbSZDZiBTHz6aiMrDX3EoJHAqxYu4Cs+s6n6cHPEpyZoLCJypX0fFWA3R
   SW6i14xVEvcYYLPHuy/sEHe4nnWSv1rNHXS06hJnEcOKRrR86Y0X/18ru
   O6ieIbzHHdt/M9iOpLvxs29h7EN7tG98HMS21xgI8aFDSr2CXLTcSYLRe
   A==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654531200"; 
   d="scan'208";a="210290404"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 19:11:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1iBeGhERaW8K2seWlLtOms6kL5PH9tH40B0vAH/6gsQLqazPkjpBMUkdjyqQ3gR419lM7XrRJgA6r6QmdnVuIqzyEn7wl+WOyis4eYNkPE2eGWtN7mj6uTEsK6fsWWe4mi44Dtu+qbGCCIWA6qP2MFwdiMQelWYDvgaAl2yrE+B3oYMC3OomByiHt3r6IbuGMH4RHEp33eB7RFWRGFGL239q0ODkUpl4DpJys/FtVXvDFqq4cbgdnSidOi/qHWJ5db+9botypfwPzUzzJ2r0ju4U/TGd5g6mXOU4U4gnFkh3WPWKKv7IqjqJtVOG0LzKVFnu/GHVZG52G1SUy/ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQf8FCj8vqJvZo4ZGnP4S8lObeOYDJK+Cv6EMh6YL7w=;
 b=KB8OhkuyMZ5E1cICi4whY/Hsk4SYGpVql34syRt0RdfqceUrvkLkNqV0jN2fRNnb7PuMgLVjRPbK79jFDEmzDEdVWeyQvX7OSBIRbCm2G5eUU75BNd2s2vG/1UADze2EyiyIQwYNOENvQPo0k0kgVEkmMN0z/8HAKRAfC44saoFMxRbyBJkOdS0xcLGQihUgaWo70jk8JQXJFeTv0HBwy/7zPOhvD2Tgln4Hujvxdo2OYH7xktjdSLWNSq0fZEy6V7A+dA90pIxXO4h0s6OeNud6bE6GtaS3OvOxRGf69gqlQyVdGUxyGlTMFBuspCFXnYzc9ZW4rwh+7h4i3OPzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQf8FCj8vqJvZo4ZGnP4S8lObeOYDJK+Cv6EMh6YL7w=;
 b=z+S3X9WgxGPBOSgT4uhrOs0ggiAG5YUqgtTctvOcknu5WbM8SlFk44lU44v1Yf9RWjwm8QYi1ne0793gm9ZssLQJ6CDn1rFVewSHeXnPteaS+lsAr1pf46XUVAoWhWbZap7vrZxFSq5urnm5axDJiAcvqPaY8HxrA3QmKjeDP+c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5178.namprd04.prod.outlook.com (2603:10b6:5:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 11:11:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 11:11:26 +0000
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
Date:   Wed, 21 Sep 2022 11:11:26 +0000
Message-ID: <PH0PR04MB74162187D8647E9F8120CCE09B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
 <PH0PR04MB741609C789F6A801747A64759B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <cbf33cbb-e539-f5e1-16fd-f8e9aba83005@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5178:EE_
x-ms-office365-filtering-correlation-id: 1d279f05-664f-4ddb-d094-08da9bc206c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbz17ibzwFG51W6j/+BwuIMsvNK2DexLTsU9WDire01BRkALKC/MRhpMV11Wl48a8r031ROlR8jldBZHJ+VVN3LaW84qsHBy+DGNXT0DO3keq752DBZg6/uPb1VSEFbymiODjUO+xjuMer1b4J1FjDn7x1aeRQ06WBo6EXZ8rB8EVHgB3i5lNhBiYArpFthHJs/0+kesPeVN6406Hbv3WztYXTbHH5pSOEjUkq/pBiJhT9qTwqeIJSNpEqAumj2EGK3PWymn82TvXhsCFODJ+buD7oAiN2ohBS1mYK11T26iK7SjUOSn3wdytluA439TWwOjcR0OPTjVBKDuAcnXEey+GdcktmSdKCrT5NKj4xpWccBcxjBeewbo6l6zv+5F4NM4lEaYTCnvjXxsfMFzlGe/Xcm3j0isLeaTO1O+zfrk3LPLb7ZDFSbsHNIgbEbCbh5ykGkCqvyoKKMjTPzp5WbqTPUbR9zYst87lgf5oF4dn4b9r+Uo24pyvSlUDjF9s10YjTLDe0o6OIyBX0p/dLncV98MqFaO1i4tDBWCGNDYMvfEImeizzP/vYZsTMJ+Oqpv8tbWozHYWmI/H3dLtCU+K17ZZZAE8xqK2fcnhy4K7pfw7xHONBR8UF0hfu6NyOzUmBMv6Vt8jvfipilFtxfPfOWyFGFV3W4nf60Qw7YyWZW9esNVNdq8SRS/W5HOROaNN8zC2HxtsaLIJT28Oo2Lu3KPPezwdbKE8gQVDhZJvCEPRI/vew8B3EgT1SYB96uyDpRcyQhIpGwW+k5yDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(86362001)(186003)(83380400001)(82960400001)(55016003)(38100700002)(122000001)(38070700005)(8936002)(5660300002)(2906002)(110136005)(316002)(54906003)(66556008)(66476007)(66946007)(8676002)(64756008)(66446008)(52536014)(76116006)(7696005)(4326008)(91956017)(6506007)(53546011)(41300700001)(9686003)(71200400001)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?54DkWFC3ycHQEg5JsYFUbIRD3uDG3U8CCwfrYyTZ5O6/5eRTQsMjCu8pYIjl?=
 =?us-ascii?Q?hrxkHE5b1cfyff2uZtPL3QPjPCe435RNNjCQVatljVE6kzzvEo8x210n2Nyk?=
 =?us-ascii?Q?A9UqKopj0wqa2z7CUjNNKH418dvVr5lCdR410AqwWSf2DdchegE/ZYVDx0kz?=
 =?us-ascii?Q?NXk/Le8lzkfeI2R7A9GmP93znwYj769jDt+AQxb9mFTWukjkC55biNP0E0+q?=
 =?us-ascii?Q?mcL1ISTw/OjrJg11Aa0EpcYZIWGZVSCQ1P6Yj41qFDCPZ2JeWMzxwE7Hk2CU?=
 =?us-ascii?Q?gyj9NcWecWshl8PU5B7mSQDuS5+FLQWhP1RV2oV5k8Fz5QAPLJJ4oFARjIqs?=
 =?us-ascii?Q?jn3iKzKhEiRh9Iysp4rE0cLCeK/N3ZeB/7l+7FjyufWttzmqQyNRTiJZ0hZl?=
 =?us-ascii?Q?7OmuXcaQadZdqws8WGikke0BsWYF3tX8XL/yTRg45heS3TmI+qiTbyWmNnWM?=
 =?us-ascii?Q?45ToghwHiqG5C4HoSLgbOBstEGi6b2ekwQ13UXh/VUtzUGIouXuIgnAp6eFB?=
 =?us-ascii?Q?sXmPU5+Yq0GLxoUjqQ9g80d3y/gk+W7e3rxJPIP2uDKMtlbs+TUnPfTBjyME?=
 =?us-ascii?Q?7My8z6Es3Xe5ckj6265uoUEuM6++qjQB+Jym1QG96fLgxEOPuPAtT6OKAuZd?=
 =?us-ascii?Q?XH6jUU5r560LkJsRpY9WtYnK5YFz3CMKT54PluPmWRAh6tFYq5lkpjaGZfDR?=
 =?us-ascii?Q?+xmHHiHsVf4xoe43J6ltXPUiyOYVNIprrcxdWyuYfmWNeZpZlxIvAXtcPMmg?=
 =?us-ascii?Q?3MwGZYphs2NqgRj3Aw/y/+5VGo8XbdaaBGrEgxZAKra3bYJOHYSO4YiPgBgO?=
 =?us-ascii?Q?x9vuKGQdEFDBTxMXnnLbsO46CV8BJti54Y/an8jC7nCgSr3OuL67+rwowLJp?=
 =?us-ascii?Q?ktudSYp66mdUJsoBPuI0/1mpo64vItM3CUO5lI2tCUCBjyC212aT4gartRMg?=
 =?us-ascii?Q?aq9U7dcb2Gwemo59j/IV9T9StQfzm5n/znDP8RsQOq4WlJO/I7VSBm35rkuf?=
 =?us-ascii?Q?Y7grC44wqvlRPbC5wxTvFfQce0IG0ZTfU5XoZicw2J5i5VhkafnVzBLLxLYD?=
 =?us-ascii?Q?+f2YmNMpQHlszasSf9DUNtjg6XXwLQTE7bd3YjmkjzEVvZYGZ/5KTEo2BDZv?=
 =?us-ascii?Q?McmuxHATMo2QOOTZAgq0lZPdDdW70eyL27Qa87eNEH2s//+NMV9Ae/WZXanL?=
 =?us-ascii?Q?Br+6yEr8CJRYSTNLj1bstm/neLkzJ2ou5HQzjuYYvxyzXUdxX7Ul8hAcC9L6?=
 =?us-ascii?Q?qT3Vk3Io7GnErnCsf9s116T15me0NLKHBN3ubqDW/5648HXNyQTit+sb7cDY?=
 =?us-ascii?Q?JIXaaAkWqtECDSSRbdgMMZEKgiK9wN6rQtcjQ5JkI327o5ji9nPPZBvNdQDw?=
 =?us-ascii?Q?T7XefcBUNzpbBxIz/Be43yelerfEG8hGsVSFlRT+v8Mz+ZwD+DkSpq+8D66Y?=
 =?us-ascii?Q?uLPCf+n5/MaE0UQZ05sNeQWrE5SKYZB1Gz/4AJO89wY+RE8I+Rg1uRmVyNbR?=
 =?us-ascii?Q?xRwyov+BDIo6E1CzacblGdrmU9CNw7CPvGmTVPVO1k3wYLRqPhBIdKEdW0t4?=
 =?us-ascii?Q?Te5KJ2PHsnXdGWh6EHCewFkKFfTMLGPqKw5itGPB/KcNc6Z2gC6YXn4gcLDH?=
 =?us-ascii?Q?bQKAvQg1wUZ03UzLLNOhDDH+y9NF50OPuZ5kjTN7IqLNAaPGH5QNOZNZ8T+Z?=
 =?us-ascii?Q?llEc67sS0rTGXHf5Xem9cCiELPI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d279f05-664f-4ddb-d094-08da9bc206c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 11:11:26.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOFcVE2nH9CEHFK6dQN4LXZYofCdxoQTo7lV02rMDLtHGxWZgY0RaFRV1MMUiOTuWt+S86v69wOUKE0W+Tpps7szNd4DQBgXYRoGc14b8C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5178
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21.09.22 10:23, Stefan Haberland wrote:=0A=
> Am 21.09.22 um 09:07 schrieb Johannes Thumshirn:=0A=
>> On 20.09.22 21:26, Stefan Haberland wrote:=0A=
>>> Hi Jens,=0A=
>>>=0A=
>>> please apply the following patchset to for-next.=0A=
>>> It adds basic support for a harwdare based copy relation to the DASD=0A=
>>> device driver.=0A=
>> Hi Stefan,=0A=
>>=0A=
>> How's the relation of this patchset to the current efforts of getting a =
common=0A=
>> copy offload API (NVMe Simple Copy and SCSI XCOPY) into the block-layer?=
=0A=
>>=0A=
>>=0A=
>> Thanks,=0A=
>> 	Johannes=0A=
> =0A=
> Hi Johannes,=0A=
> =0A=
> there is no relation to this efforts.=0A=
> My patchset basically aims to add some support of IBMs =0A=
> Peer-to-Peer-Remote-Copy (PPRC) hardware feature to the DASD device drive=
r.=0A=
> PPRC is a protocol that might be used without any OS interaction on a =0A=
> storage server level.=0A=
> This patchset allows the driver to recognize such devices correctly and =
=0A=
> allows an user to make a copy relation known to the driver.=0A=
> In this case Linux is only an observer/user of the copy relation which =
=0A=
> is set up by an external entity.=0A=
=0A=
Thanks for the clarification.=0A=
