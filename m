Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EA18EFD1;
	Thu, 28 Aug 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388238; cv=fail; b=KXkQBpV8kxdg1KKvHRmFUaqCCZhDBS+kpuV9ECKEaSgHypt1LyN8fu35OOmYUqJ66NCV5CxUKo9e7PaHKcnahCM82+UkMh6eD5ckN+rhr1fjTb844fs7Q3hQxiUFyCZ9hnUIL7awJZpMEC+D3EO3EMqtAwvWb7Zhu43Xehej61I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388238; c=relaxed/simple;
	bh=4HZWQxpUjidxiavTECP9oqQHCanRZTSbrD9HrgQaDVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D7n48f7PAwMNniaIlZRIprEobQRuIHny1+w10LoMEmHead019WjqAhunLH0drc/vpFXJx+HIF1x1nnKQMVK29ryoqCnMV5aECro36V1V6o+WtPMJvyLNRSWy6kufvvqP8So3z/2yebRla1k7htcWrHnxg0+zCQBbgEQvaTzMXO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r91GGD0j; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r91GGD0j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlFjgB4bzFNLt7xHb9BubknTRvFmVJk8n3gT5AUKeK9EPXFgLNzh0vn19RDtZvSRjj9fIqL9Z/a6bx5W7shyRMbgvNd/WWJIW6HXGvICSOreN1JS5qJEgONEz12OvN0VtLzrqDoVV5ddUj/ZTz/1uu6MZvS1PEI13bB+mFmqeBP4rXMYTTPmeKavrnNuKaqDMQt4SyO3lpDugZqC4PWdgH7iVFCyLm6XNWjBhlNvF+vFLZuTQx2NayuMlp01Yv6RzJViYo7eHnIf3ENKLbE60dtKlKDPbDpyu74Lr6np2jTJSWsUP0R0n8ic8oZ4Fl9P+Ry4VuEeh/edFewPvW1lPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74DxaKMMv4pbsSkmTktGnGL8OXJdqUDUGWfckResyfc=;
 b=qrMXt1AtQIlmd59/kV+dgy6ZNi3+H5JlIvAhdc1p1pDuSZUxDJs7pd53WmAJCcGtsRLDLrRkFAwaSr+iJq1mZkIaumgiq5v/VHqZ3RPAlNu8Caq0bZPXIEFR7Ci1yfhgjPVuaJKvbYhhEIvkMcdaI5aHPi9WNZY7WwMle+YtiUur48747V63CRrhX0aG+8ENxfPHsOgvdode+2w/BqK1fkLFnq31YxwE1JCuhsyPdbMC2hJyPZfW5EFwo1G1OMX32FwZeQ6q010rMebeibhZz4tOHvB1dkxdo424Lb36Knrtoy8QNxe9aXEPNe5X1BUFjcDD3hZ2+74zHaI0n9U0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74DxaKMMv4pbsSkmTktGnGL8OXJdqUDUGWfckResyfc=;
 b=r91GGD0jASoJQFMsVcBAEb5LtjlPuXnbRP8gtRPh2S0dWrmO34krBCtZNqvYCR+H9KtqrU0GMuhauGrin44r+cxwlLLDHs9cvgrupGdtmoRTTvciE1zyhcwAV17ese1Iv104xwEEsCrAu4R8MDRPGv/YzJbfIvATjY9K2M3Wx8GNIgz093So5UxiLayA0xGemW53nev6/439Wr7j4QhP+xbd0Gqyd6y0ZNbYB/wJ02ipAKvHeUBD0obdrzSb7dfKBpW2WWVi/ThAdpbIPZbPtStoGNJ0uWKReyqUhNu1hDYJPq1FKne94qUglc41+mLe8mq29IZ4LrkhE5Z6vqgxoA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 13:37:13 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:37:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: RE: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index:
 AQHcE0XKqVbu8cWtaUCLZj1LjgeTGbRudpsAgAAWuWCAABaPAIAADA7wgAADewCAAmIWsIAAy/cAgANp/uCAAQYPgIAAFMmAgAEqTRCAAHQBAIAAALwAgAAA6YCAAAJbYIAACGEAgAAEi7A=
Date: Thu, 28 Aug 2025 13:37:13 +0000
Message-ID:
 <CY8PR12MB7195FE97D4B0C56BDEED6DB5DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org> <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com> <20250828081717-mutt-send-email-mst@kernel.org>
 <87a53jeiv6.fsf@redhat.com>
 <CY8PR12MB719591FB70C7ACA82AD8ACF8DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250828085526-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250828085526-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH3PR12MB9219:EE_
x-ms-office365-filtering-correlation-id: 4c7a27c9-305e-4fef-9226-08dde637ff37
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ouxk0UufMdYrgIx+ldMOWiADp6jcKAz3/oa9jiB5Uzp+KPZ9zUd6voBd+7Al?=
 =?us-ascii?Q?xgRtuqhReXqa9mgJHIEESiwnAM88AUjNFnndIvdU8JAmRaQgR3p9q/gJ7xdU?=
 =?us-ascii?Q?tYe5yE3wCj5sMcT14xovBCDy6xHSkCeJAvcMehVNNpavnkGkEsJWUdFap0Z1?=
 =?us-ascii?Q?05XalKI1C7lYkREMkXQJuDCKz8mI+rOdJ+kBkXehPPgh5corm+jJ/vpZMlOY?=
 =?us-ascii?Q?DrLPPZitQ9EZ9uRuSItIQO1uHGKyW3rxio5ZbuZQVIGSv3bIvi5Uq1nB0lh3?=
 =?us-ascii?Q?8VBP4/GBqgqofXa/xOn6MOfl49hhiFSVVrKgrI5OTVHUJxL5y6yXAkyR8+ER?=
 =?us-ascii?Q?DVaf6RKhrlLAMK2nlx7OjKKX0dkYnU9Zp+UVRoFK5mnU4teoDXTTAzxOdn/r?=
 =?us-ascii?Q?Lu1ai8xW0t6zIKPPK4jSjE/WS1GdPaaVQKO1C3Ve+06xs+z9eUIL2OmAl7S9?=
 =?us-ascii?Q?HFHW5rIUKXcKb21ZHrZ1MT0ViE+VUbQbh9DLoKceIaBgUqmcqUGygw76s3hG?=
 =?us-ascii?Q?iXqf0yTN5dQtZeVniOqyiv6qxrLw7OviITxKe13ExM5dfl1/nC4lN2IKEyMa?=
 =?us-ascii?Q?a9G+h8F5N6wbYW8o6djJKYMYyVU2Ta9wdx/GrA77/gz64vxBzASpTPTp8SIn?=
 =?us-ascii?Q?Gl7UEw3+4vKAbesO1O5fdmeuugHBgnKQxCzewyMRko/I+EeJD7bO0qsJMmUo?=
 =?us-ascii?Q?ir9YeGfwPGQSmHdV/P3J52Yomxvtf/k/15LRyhTlSDPZbmRYUhRFLckl9l56?=
 =?us-ascii?Q?goq3nid+1BYMxx1CeM8VIn6QfNeTUCJF5mn7j6678VhUQriHQB8rUctbheyJ?=
 =?us-ascii?Q?VfLuRA0y7hryq5KsPGrVlOJvvjm5vY3BWL93vWB18Em7W41ABL7ZwPq1qAwd?=
 =?us-ascii?Q?WBx1zl6PEqg/7twSh1t4MWgsLh6aLNYd3o320PExiR3UZx6O93fP/S2W3v5f?=
 =?us-ascii?Q?VyK50cNlS6Q6npbthlHu/OytXA1oLZS6aqmVTBG/H6ZZCKbSH6QctEyhSp7K?=
 =?us-ascii?Q?geDVDBFt1ABX1Kaet90wDLPXWKlQD1s6jzb7DIFej9oncrA5eu/9/s3YbK6b?=
 =?us-ascii?Q?MQgQnLLBrO/50rjeJXtXERfWXwUY7mlo4PeprecSrTqapY4ivN4MGNlnjYH/?=
 =?us-ascii?Q?BMczPywwX9nun77sBUtEoVv2eOd451FJ2J8IOTugvUbiBnvHoi6fgB8xWX0I?=
 =?us-ascii?Q?4SPrObozp3kX92TLgt3S8F2N4POTDpBRbGIWQE3v3wRFRdMW8n3Z/wRXew5d?=
 =?us-ascii?Q?9WDW4AxMJkSMxYO+pp4t2E3fhI0+K7EXDE8sVKwaRiTSFABpuYHZT/YX7Vrc?=
 =?us-ascii?Q?Ll6FSUGiztxRMrf1WPp79wBp58p4ehVp91xrX1ygjBoM+N5p7K51QOHTcOWC?=
 =?us-ascii?Q?wkB3300CrKLKpKow4ykQ8iwhKY9aKPAwe/Lagn0BMzXzP8TYqBsgAQMbbhAU?=
 =?us-ascii?Q?2Lc5fFa0fwYSRnE7yYVzEkaOnrl3pG2rSzJYuzAv5EL5Txv5n0/9PA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X+Pei6zau9xxG5tuP36WYLxmv8SYuyoettwrHjgmW5qLf31lelDqNQStjp6i?=
 =?us-ascii?Q?xXOP2EYEdSvrFiifQs4XR2vDlpBHf6ai6lKRXRJCttSjyTP2wzwqVTt8H/8R?=
 =?us-ascii?Q?TYSqyIiQ6/e4A2aTfwaP8MCCgEFR2RvJJU/KykwOPXn2XvxHLnYlW/IIDzS0?=
 =?us-ascii?Q?CZEmOIZ1J11qSzmNtgod1iXFgMHRCvwSK3Df1UPBj2R8ai4cUDNdFyDjhaT+?=
 =?us-ascii?Q?oIu9utf5rIOp392p0HUJlYTARa96sizkKzZBL9Bbv69nts6nzA7UPNyck4vT?=
 =?us-ascii?Q?HiXCGE7xRkxNv8lhV6Tou0ds4K2KYXvQhCL420TVOUxFycldPXLpH40YYmNp?=
 =?us-ascii?Q?oN2KzV6wj8b3MLdUMKRHJ5q5ou2SARx3qu8UOr2lEQbzZ77YUp/DbnQv0XBX?=
 =?us-ascii?Q?1AIjRV8tVCBgEJUVSh0lPU8k883bYmqAUpnQGQ5KclEkivUsy2fLBb8Cxjnw?=
 =?us-ascii?Q?jpnd0bIKCxQ0XQDXLTiN6n73YthyfRU3K02lWYFpt1XkzckPcpsAGuVpM7Vm?=
 =?us-ascii?Q?Zo3n8UmuOGtKFEvq3af84P0t4fDDaEKwR76rXoK5cHN4SdExFuFJng68mk8e?=
 =?us-ascii?Q?Jc/4ew9wvWtZifHi2qCR08tTai/88jCbHZeFrNJySSXTkm5poC0T0fhPhu+D?=
 =?us-ascii?Q?W7JAKgdXOHwFIYMwLTiDDPGYAgvw7c5ulwJz3kpBbDZ/uDYadS8MsjnRFdvr?=
 =?us-ascii?Q?ChlNfqzvm/ELRgsh1o9DKuseBibenypFcF9oZA2kytaxnGbOOaGCWy6xBVoj?=
 =?us-ascii?Q?PnEAjMEYqWk4kuGtTbiCNNvS3/QuF1AGcx8dK/hl/cW1kH++hDj+fREXAaEi?=
 =?us-ascii?Q?Cpa0kBXVGihAUgZxRDOhkQ8ob/u95xhtypATx/dyMPeCy9LKDKzzLRGQ4QJS?=
 =?us-ascii?Q?V9CLPFEV/CuZSsxhSnhAHxqMz1Wbqr3gxQ6XSxF8AhZY4Q1izuJBJUh9GbkP?=
 =?us-ascii?Q?Pyvj2H5mflCyaBeOpWgyWld6VPM54IjpziPi+Et86Ma0wa0mK5h5fTqFsFBH?=
 =?us-ascii?Q?VPO26cyxhQupoR53RBsbsomO5QQD9rF71zYbqdPv/TE79h94bRK6ya7KZjsx?=
 =?us-ascii?Q?tACBeQN30owQRR1Y3MMRUTvSCBlvY6PNgiZTvoIOu425M4zVIboIpVSiq8/V?=
 =?us-ascii?Q?+w+3m6sSSwqZ/nWIPJlIi+MnVYov4FiaB6L8iv1iKYiGdlq6x0CFmxwHXeIK?=
 =?us-ascii?Q?2WPyys5gzm2AZBSArgYHvKoJYcBEOyd65r0gA+t6zYoR0CZL5p3ib9Sv1Tay?=
 =?us-ascii?Q?PcOjR4YwqOs4s4w2s4USsC24WaScUq0vy1qoY0AEEATUyxaJdPEHR8ZGBiHr?=
 =?us-ascii?Q?0zlb9X0bONLhVQHwciGs6wBwic2d+IkUiArKBH0lLMXpRTGOGvPiLGxKxRwU?=
 =?us-ascii?Q?onPa8DDsKpIYskSvTYnJuudKeOAwTA+rzWb7mRwrJXUyUnAVio827B1Dci7C?=
 =?us-ascii?Q?pLCM5DlwpDyY0DhXALAWRS65SerFrVXlMS8cp27gRLzHqxxtIxTzzpkEA3yM?=
 =?us-ascii?Q?Bu0SKpVy1xrtWt70GjBiebQA4B/4EOgo8US6KvaoSsLjT4CLoIQPjoI1Ro0J?=
 =?us-ascii?Q?JMEcvezLBPUnnmp4PC4wuQiMkBpSq0a533eEtYKA88xUeXv7KkbRY3VYkvB1?=
 =?us-ascii?Q?Zssou7c3zDgR00Tx1cl1+ZfM7og6P9ZXnunV/jMiNNuW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7a27c9-305e-4fef-9226-08dde637ff37
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 13:37:13.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSuS4Ly+KG6aRNabRUSriXrLhet6YrVXDMWyWiYODJIM2LTsr8K3aPAHN+lp+o3UHDz25dRt1lGNqVoK+tnItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 28 August 2025 06:31 PM
>=20
> On Thu, Aug 28, 2025 at 12:33:58PM +0000, Parav Pandit wrote:
> >
> > > From: Cornelia Huck <cohuck@redhat.com>
> > > Sent: 28 August 2025 05:52 PM
> > >
> > > On Thu, Aug 28 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
> > > >> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
> > > >>
> > > >> >> From: Cornelia Huck <cohuck@redhat.com>
> > > >> >> Sent: 27 August 2025 05:04 PM
> > > >> >>
> > > >> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com>
> wrote:
> > > >> >>
> > > >> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> > > >> >> >> > What I do not understand, is what good does the revert do.
> Sorry.
> > > >> >> >> >
> > > >> >> >> Let me explain.
> > > >> >> >> It prevents the issue of vblk requests being stuck due to br=
oken
> VQ.
> > > >> >> >> It prevents the vnet driver start_xmit() to be not stuck on
> > > >> >> >> skb
> > > completions.
> > > >> >> >
> > > >> >> > This is the part I don't get.  In what scenario, before
> > > >> >> > 43bb40c5b9265 start_xmit is not stuck, but after
> > > >> >> > 43bb40c5b9265 it is
> > > stuck?
> > > >> >> >
> > > >> >> > Once the device is gone, it is not using any buffers at all.
> > > >> >>
> > > >> >> What I also don't understand: virtio-ccw does exactly the same
> > > >> >> thing (virtio_break_device(), added in 2014), and it supports
> > > >> >> surprise removal _only_, yet I don't remember seeing bug report=
s?
> > > >> >
> > > >> > I suspect that stress testing may not have happened for ccw
> > > >> > with active
> > > vblk Ios and outstanding transmit pkt and cvq commands.
> > > >> > Hard to say as we don't have ccw hw or systems.
> > > >>
> > > >> cc:ing linux-s390 list. I'd be surprised if nobody ever tested
> > > >> surprise removal on a loaded system in the last 11 years.
> > > >
> > > >
> > > > As it became very clear from follow up discussion, the issue is
> > > > nothing to do with virtio, it is with a broken hypervisor that
> > > > allows device to DMA into guest memory while also telling the
> > > > guest that the device has been removed.
> > > >
> > > > I guess s390 is just not broken like this.
> > >
> > > Ah good, I missed that -- that indeed sounds broken, and needs to be
> > > fixed there.
> > Nop. This is not the issue. You missed this focused on fixing the devic=
e.
> >
> > The fact is: the driver is expecting the IOs and CVQ commands and DMA t=
o
> succeed even after device is removed.
> > The driver is expecting the device reset to also succeed.
> > Stefan already pointed out this in the vblk driver patches.
> > This is why you see call traces on del_gendisk(), CVQ commands.
> >
> > Again, it is the broken drivers not the device.
> > Device can stop the DMA and stop responding to the requests and kernel
> 6.X will continue to hang as long as it has cited commit.
>=20
>=20
> Parav, the issues you cite are real but unrelated and will hang anyway wi=
th or
> without the commit.
>=20
How is it unrelated?

If it is going to hang anyway (in your view), and you proposed different ca=
llback etc as brand-new feature to Linux kernel, what is the objection to r=
evert it?
As you pointed out it will be in multiple subsystems (net, block, pci) etc,=
 why not do the proper work?

Reverting at least helps those stable kernels to operate smoothly as before=
.

> All you have to do is pull out the device while e.g. a command is in the
> process of being submitted.
>=20

> All the commit you want to revert does, is in some instances instead of j=
ust
> hanging it will make queue as broken and release memory. Since you device=
 is
> not really gone and keeps DMAing into memory, guest memory gets
> corrupted.
Nop. This is not the case.
What is "some instance"?
The virtio block driver is expecting the IOs to be completed without the ci=
ted commit.
As you listed cross subsystem callbacks, such infrastructure !=3D fix.

So to make things clear, as discussed.
1. have proper kernel infrastructure in placed as you outlined the design u=
sing callback
2. have the spec update to make sure drivers negotiate its readiness for su=
rprise removal and do not expect to access the device.

Until that point, restore the stability of stable kernels.

>=20
> But your argument that the issue is that the fix is "incomplete" is bogus=
 -

> when we make the fix complete it will become even worse for this broken
> devices.
I explained you that the device was doing the right thing and that is why e=
xactly the call trace in the cited patch showed up.

Again quoting "broken device" is wrong.
The drivers are broken trying to reset the removed device.
And the ask is to do proper feature negotiation to get to that point.

When the reasonable workaround is suggested in previous email, you opted to=
 not respond to it?
This is not how broken user experience is restored for stable kernel.

Are you waiting for the test results if it works?
If so, then yes, it makes sense.
I will of course test and submit proper v2.
