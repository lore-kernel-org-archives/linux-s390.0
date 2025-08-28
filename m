Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF38482EB;
	Thu, 28 Aug 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384447; cv=fail; b=QEXbMpj8CvvZd9dFiYVe3HfrsD4d1z7Ks6SmC86VnUym2+Envy605kgNrZGzNLO95M2RHC76T053rd8DKkONr0MVjUj0PwxJ+CfwTy6pDZAfJ7xgFU4S2EQwQNL0+G163Bh3QO7Lug7Hesu/5Vlo5dbnRzncyEZtx85f5E5or5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384447; c=relaxed/simple;
	bh=CEJvjtfZBqUMcI1mLCF0fv5mhlPJIBQN2gSquZS8ue8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jaHJBGZkF7zMpBVXMCKeULiwezxRlDt6cwExZfNiI7GWvz3yYvc2v/11ptMywodrwXjnStvr8BBZy/Xd8ncb+0VVdVKCb5pcjJ9EpOXjMYSNP1VRaWK6yYbZegIBEfQQaoSr5t7qeY+ZDKe90cF9mAWK59hiPVqYQeTcgOINFek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FgOheL1M; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FgOheL1M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iafwhbZDCeDCfrjp2EJSuA+rj0P7o7v9+PFDD4j0QAD6XNKYwUPkDz9CMUFGIgT+JcRLTNnptzuytcNa5avaCoQFJkDzs15w6qr3VNgw/srbKwwTjWTDDD7wJgL4TeTO5pkBppdlk7TvwHW/mjYilC13xm447+emrcgM5AWuuvWWEWTkrlKl84ciTIEsTdlXLRYrzSjH8GI+pWCCaclJB+aWjAg9c9B2XU+Rv2AlCVPO+7NT9UDKOl6aeDBKCn1ZkNzi+2yA6qHaAf4vEDCReCI1EYGea2XMT47nZZEyyrygIRCV60JoqFMz0Q9IUCIX9qqec/kpxJd5XSKShgo+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAPIt9DW8t68g0djsjGQG3ql7dEKW81BprDxOoNNQmU=;
 b=PzfGONshi4g2T5YVxdPoKVjE6sjFW1IaPrBPBU+U5B8M7HFHuxYAU9v+2SZdxA7T6HezI0Hg5n27Sns7fLmfi11f5aNC4vP9ciRpKkLyLnCrwZGYYtFvX3itX2L4LQ+pIj7tPXEeYOoAMKDzGpv2+NZyjFVRUnMjRnCXbGzTFroGRajB7EHeQNql8px2C0a53n4A0Be9ApWExQ9HbOvidEDtmJ7W/8irro9cFngZKb1+f8REtHFfu2sIu+VRcpsbI8culRYwbFQ/gkD4pKDjOiuZQLO5f3zuTHME08C21y5U5w/Hoz8KGgIVdva8ZuvXHcC0XINTe9Dqrwch0ONgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAPIt9DW8t68g0djsjGQG3ql7dEKW81BprDxOoNNQmU=;
 b=FgOheL1MmG0cq5Z6id/ejtO7zPtWDrI2PlMj1xk8gQruzLSQBysZ7oj6B9G0vFzJTM8Ioa5pcJZf6m707gAeG88kuK3wX9Li4BVT5AcUXC/9gIf6zVZx/7mnL5drYjGpq5l99IPjUjNwhtaywy6C4WRz0B5eju0SQk89Kh6mGksPcJeuTNSSwx1caL4Buv3SKsriyhxKkpR5bZMBGzJonHwRQfpeIAhyrZvJqhttAzYLEirva6VnEp/r/Rz3pmToEmErDgdooSvvpwqJgqQ7BFZvVcJHt4DH8UQZwt4gKwq8M2KAR3JY1ICZ1+lblMcnVXPgdID1/hsPiqyA63Cfng==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS4PR12MB9747.namprd12.prod.outlook.com (2603:10b6:8:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:33:58 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 12:33:58 +0000
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>
Subject: RE: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index:
 AQHcE0XKqVbu8cWtaUCLZj1LjgeTGbRudpsAgAAWuWCAABaPAIAADA7wgAADewCAAmIWsIAAy/cAgANp/uCAAQYPgIAAFMmAgAEqTRCAAHQBAIAAALwAgAAA6YCAAAJbYA==
Date: Thu, 28 Aug 2025 12:33:58 +0000
Message-ID:
 <CY8PR12MB719591FB70C7ACA82AD8ACF8DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org> <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com> <20250828081717-mutt-send-email-mst@kernel.org>
 <87a53jeiv6.fsf@redhat.com>
In-Reply-To: <87a53jeiv6.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS4PR12MB9747:EE_
x-ms-office365-filtering-correlation-id: 66477039-af58-4b57-9e71-08dde62f294d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6p6Dfav+TKTnk2ln6M1zckeocnwAI6RNTyThA/fMGvzt/hRnLUdLF2I2ayNY?=
 =?us-ascii?Q?BCU734MpH3ZtQYYYjjN0h9s5E1jMXleE1oM833IamM0c+AJzjKpx1jZCZOW2?=
 =?us-ascii?Q?gnGPSZ+osKhc9P+haRk8cF0OQkM/RNCwCFLMaUlccYDDcd8V1gJbH/cXVDD2?=
 =?us-ascii?Q?XIhp4tjUEX15eLmPsqjZMWEtid+LWLZ72hACDJSobstPXMWSBygPDc+XXVHp?=
 =?us-ascii?Q?LD2Se4zTTeH5bDxMeT6u4vgtMnQqVijueAtwoBpOjRhOjmK5I08TuMaUF5M6?=
 =?us-ascii?Q?ayEqYUntGIi4BQmdqVDPZ8nYmo/li05Sz4mCk5EFrtW3Y7W/h7MbonUipSvC?=
 =?us-ascii?Q?Dz898EdhWUn4UUVKW19BCrMnYxx/eo/zn8yjL01jbr4M+SkPBymyJLDMBLCc?=
 =?us-ascii?Q?+ZwY4KmQxKaFL4i86a3X2QTeITK0WK/E8B0xF5DLNrtQE/LpPaxfwxHC/LvC?=
 =?us-ascii?Q?FDC6WnJejLcYqu0xzU/GsA+1hMROR9e27kq32yVw5qnMdDVRTyzd8WvMHpKy?=
 =?us-ascii?Q?pxQ0ohRphBDfFNdcc1wZEn97+/r+d9/7Gaqt2nbG2PTzV70eNa6/hRtYXkLr?=
 =?us-ascii?Q?HVx2tAvJaSydOVYAwmiGfvA4UqdOooggfCww9+2KeV8dxkcdEGs5DX01EmuN?=
 =?us-ascii?Q?j0/cBkw9FGcTPk+axWYmdRYUJd2n4Osj1wUn3VOW3D2fXMr30YhUO1fv0rPn?=
 =?us-ascii?Q?d3aq0f65xG9iRZfL+U9AhoYRC39yING9tKX+fYTRpnICacDUWZX/bKpctOq5?=
 =?us-ascii?Q?ubgMOvuFMvNW0LZuslRM/iwudo6Qp529t3pByKlcqH8SlQ+4FJnaRMWd9CXk?=
 =?us-ascii?Q?mcH/GKDf6xMb53N0Hcs9ymDaHnWq82Qrzf2J3XxI0UJE2HnO2Fgsbu/9NB75?=
 =?us-ascii?Q?jOijP36F4Uu1UPLsdwdfIvx6TU4HR+nbra7T/b/b9MsOW9XjG6++VRsoeJJy?=
 =?us-ascii?Q?7kvsd2/jaHd/30eMQiXBa83A4bTT+OfX2P2ehd3NPqhyxAzFWHto+/us2SMT?=
 =?us-ascii?Q?631KV42EzHMvtjHx600DjSD+yXj3pf8piGoPXOofY/nluBZhz4et5pl+KlV4?=
 =?us-ascii?Q?y8Bj3fVitHSBgLooInjnv4zk8LlFvv0AarOHLvgBe9wWfr9ACTRn1mBQjfmK?=
 =?us-ascii?Q?DuZOrHZPQ68QOG/k+6JVBTHxfaWC45uhEbjL27uuOOEqPAs4+2cNSilnpNGB?=
 =?us-ascii?Q?rHFP/ocK9XYl28WjXRoCYtWtly153lHp6tLbxcoUkXnRnSh+QigxVPbHawDA?=
 =?us-ascii?Q?cWxOAdmQv63XXJ4aq4ecN9RFxkC8hT+xE+tp32aw5CeKzd53+QT+9qGPHCQQ?=
 =?us-ascii?Q?9RmYr631teHxwpuul/7jB3jP4QSAr19TG73HINBCL6MWHqLeFP0IJe/u5wX3?=
 =?us-ascii?Q?P6v8MBTaybJVF4VVlDxWXC5sPYlslVvQ/f8mikAjndEdlaibqXmweDlxNVX0?=
 =?us-ascii?Q?h5noiHFWjUUeuO+G53/3qFVur0o9e5frvq9i98cfrayZAt5mwbMPnw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i7evOPfullFbfEPp6w+Ggi6ISl+kWtRtwpiLr6Ke7W1dFxYW79WpH8VDtn1W?=
 =?us-ascii?Q?vS0jQF6TRUK0Vd8+y+pzBrdSssJ6bA9xX6gc2Sljl9lNUuAqNfmc9La8h9mA?=
 =?us-ascii?Q?TQcFqsgD8nAalpytZP6Y9y8eF2wChqbBgGk5eosYIS+oo0rOWi2L+Z1j1hEn?=
 =?us-ascii?Q?OdJArIkTUXmXLKOe6JI2aEtrdvg9KbeCPONk1QU1Y0mcMGUBnZ4x1u9jwq6P?=
 =?us-ascii?Q?cfjhFAHP3UdBiUSG2OJsB20dnuQn+oq4zBn2CqWT41HsU2oX6JEeodbY+5KT?=
 =?us-ascii?Q?I/aduZVH/7DvAgcPzu8MB3doaNq88y9WwCeqiayF2LBDBoOYWNGvmCcuAFAA?=
 =?us-ascii?Q?/b2NgrVyhldA+uWBZStzjxF2nlzUtmLMnOgQr5rw/XetU8VV+BZ8FNiBH/Qr?=
 =?us-ascii?Q?tVW5nVve22+1vn7BZnE5RR/BN0oowL5DLbdD3S+KuFligr744cgIlufQr2Tn?=
 =?us-ascii?Q?t+liXV+5NINMfIvZLF6XttFgG3RlekxsaJRijSXU3HozxJFknCwyTYcOItZ8?=
 =?us-ascii?Q?VMaiqHvM9Wv9zNlih/yRYl4IIXiPUbEujhGyAEmrj8pCwiNcCtEmeOVltxWQ?=
 =?us-ascii?Q?kODdO1LlbeGnK9x1z50/X7W/I3QHR/8QutC+gm5kL7FRwY3pVAinrj/uE598?=
 =?us-ascii?Q?CjcKaQiaO5Va3uWz+BteWP1KwLMHbpRViMgyVsxYUpZjUlFE8F8EV+ktGGJx?=
 =?us-ascii?Q?B/YMkeUD1g4tEf7w3DXHCTj5gkzJr0zUB/JZ80qZTF8jHVaJDZ7InqO38n9X?=
 =?us-ascii?Q?XVEtdU+aWxv0FCXZWgzPq5rEVGq+OSPrOg7cJdBRid5YTXtE6Ty+JZjNAdF0?=
 =?us-ascii?Q?QseErwP2tey64fHvRlQ7T6OHqe1GsGtlp6tp2A1vZy8yjStaXCcJKmLy/N+3?=
 =?us-ascii?Q?evcMej1KaV77hHbvIm6oISESwE9GYYyKGM3XIbvgr2B20FWLPo9DHdcGFdAk?=
 =?us-ascii?Q?r1raN6O8ya8xBVmGOzWHdA27eYzXzYQoPO4OjF+3/siQI3rve0lVwbTgQQNw?=
 =?us-ascii?Q?4gLwtZ6+di++vmaHT2AHifxHSwByrhEI826oWqRs1pHPDRT6naponrP/ozCF?=
 =?us-ascii?Q?mfbVFp9X8Hpzy3V7B3xpYef+cI7lBO4sq1LL9JvxGJfrTyTe3E1eznkeLy/A?=
 =?us-ascii?Q?l7zpjKANcRTux+K3HFMjFXlbqOM7GODSstH1D4LiV6bWKIwlWZ0+8zZSasbX?=
 =?us-ascii?Q?CoTMfgwRSvRdQLK+4lq7klaL/0LT74SMQL4HkblvK/KLFQhTBu4PzxW9Vsdl?=
 =?us-ascii?Q?04RBefO4vDphsWlppXm0OXzR4E1gSvFJ8Hur7z/N90/Sr9ZzmiqdSjZ7st6f?=
 =?us-ascii?Q?x2IWLgWkTqK+JVS0jKrwABJYn1S6kMANCxDvIDLZMvUllB4ocPVxpP7m0PpM?=
 =?us-ascii?Q?EbS5nusuyVEsCcxuE0IkUk658i0xL5qNEXwqvyGU3vKJfZQFW5R+Pe0AW/Iz?=
 =?us-ascii?Q?tMlPAaQkItm2FlxbdTaHAVhBwHnPGdVFIbomkwaYPeo+PpVwW36VldcRbyWA?=
 =?us-ascii?Q?yOlibQOi83HHnw4jo2kfttxWt8dWDGNC8xPO6lNR8loqYCossQ0IFpBHAqe0?=
 =?us-ascii?Q?1egM+GeD3T24XgU91Y7gMHhutfzBLnR0UbCjd3skJQ8ykbblhZKgdG6Eb94L?=
 =?us-ascii?Q?b23nnY1SQ+pU3hlVcl4wlWkh+GsV/LcAY+sYc36Tqehl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66477039-af58-4b57-9e71-08dde62f294d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 12:33:58.6894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kctntmWOei8PR3JX7WGTLerGXp+xAXYXEyOHHfYXV8PNPAj5eEsYqUVQtfbEHkGUaThpygYbptLzX+atAfCmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9747


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: 28 August 2025 05:52 PM
>=20
> On Thu, Aug 28 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
> >> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
> >>
> >> >> From: Cornelia Huck <cohuck@redhat.com>
> >> >> Sent: 27 August 2025 05:04 PM
> >> >>
> >> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >>
> >> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> >> >> >> > What I do not understand, is what good does the revert do. Sor=
ry.
> >> >> >> >
> >> >> >> Let me explain.
> >> >> >> It prevents the issue of vblk requests being stuck due to broken=
 VQ.
> >> >> >> It prevents the vnet driver start_xmit() to be not stuck on skb
> completions.
> >> >> >
> >> >> > This is the part I don't get.  In what scenario, before
> >> >> > 43bb40c5b9265 start_xmit is not stuck, but after 43bb40c5b9265 it=
 is
> stuck?
> >> >> >
> >> >> > Once the device is gone, it is not using any buffers at all.
> >> >>
> >> >> What I also don't understand: virtio-ccw does exactly the same
> >> >> thing (virtio_break_device(), added in 2014), and it supports
> >> >> surprise removal _only_, yet I don't remember seeing bug reports?
> >> >
> >> > I suspect that stress testing may not have happened for ccw with act=
ive
> vblk Ios and outstanding transmit pkt and cvq commands.
> >> > Hard to say as we don't have ccw hw or systems.
> >>
> >> cc:ing linux-s390 list. I'd be surprised if nobody ever tested
> >> surprise removal on a loaded system in the last 11 years.
> >
> >
> > As it became very clear from follow up discussion, the issue is
> > nothing to do with virtio, it is with a broken hypervisor that allows
> > device to DMA into guest memory while also telling the guest that the
> > device has been removed.
> >
> > I guess s390 is just not broken like this.
>=20
> Ah good, I missed that -- that indeed sounds broken, and needs to be fixe=
d
> there.
Nop. This is not the issue. You missed this focused on fixing the device.

The fact is: the driver is expecting the IOs and CVQ commands and DMA to su=
cceed even after device is removed.
The driver is expecting the device reset to also succeed.
Stefan already pointed out this in the vblk driver patches.

This is why you see call traces on del_gendisk(), CVQ commands.

Again, it is the broken drivers not the device.
Device can stop the DMA and stop responding to the requests and kernel 6.X =
will continue to hang as long as it has cited commit.

