Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD43F65E7;
	Fri, 10 Jul 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676093; cv=fail; b=kGnUJd/i++FecNzemSxuc2wgXMVYF/ppr9eLoUB/vG5xWIdRW3ua3puMi3gwLDLUrChDQ4DpIz0xsuh/xYtzEBRV6BZBwjIIqVVvT79SukcrAQQcHFn6/i/q0tzqEJrtkPPMPspUptpg1qtWPmGpIpoy+xGq5DPCEMKm3yUJ+TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676093; c=relaxed/simple;
	bh=ODcGxiUKiS1j9MlUipuvJOfkwE9H3HLH6IqA+SPBOYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q8w6SWBiEJ8F7ZjWzqfbW6qS6xU5OJnR6YxuPwZ4kz05jzOv+JG/aequ59dn42txXcGibls6CIf0rXsAtyGj4HfKzoU1YgMbqwNVAc7RO7GHfie1yzprXFN0Jb6EzG9wbswX/3NyoRIiR29n2PKKg69rVezOCYzNC/z/tUSkNjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHMHumR7; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHMHumR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783676090; x=1815212090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ODcGxiUKiS1j9MlUipuvJOfkwE9H3HLH6IqA+SPBOYA=;
  b=oHMHumR7ZspXx4RxM98yUUpPVR7I82Rtc5y0mEhZCjh+K52EvCPGT6Uh
   wNV5U6Y7i/5rg2D1XG6zdgHEAZWdWbx41DIx113X+rzlDVdCrVmsBnfKq
   iA7EY0P5aGlECE0qcLx04Ns+b0pn08cI/87//+5nO6CjQyYM4wHoW1bLn
   T5oXBqZNkf46cuebCtsAlArc3gPUhqYv2GGEMsnpQ8ezschFszQpFy1IO
   KRbJ2UnOxAY/baIa1EH4GXGU97q0PEWNGZG0s3D6V7/dE2n677/rqHQ53
   /p2n39k4rKHkAs/LVO3O93Tdr2PmgLgim8PwPEyzJoq8Bx/nVHpJxHEwX
   w==;
X-CSE-ConnectionGUID: jix8Po4hRNaji7nBUESq0Q==
X-CSE-MsgGUID: v4nLd0AvR5KYDQl4zwxRCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84425524"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84425524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:34:49 -0700
X-CSE-ConnectionGUID: lU9ivxAcT2ackfEVLKl3gg==
X-CSE-MsgGUID: WbJ1FO38STuDrMRwn+tN+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293041101"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:34:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:34:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:34:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/clDkcOwLVon3ZY+n7r6JwoYUnznk/YZdb7UWLKRa8wHnQ/wPm2N5nlyeqAsfbgEjDNbE12DKDKvuz2dSJe1AbLMi5UaLjfe7LI8fmGBDToi1C5Nf4ddBNQAvlsKuss3QR741I9mrUiBnZHd7YZLCAzAUJzHYWo9P8vRVA1u+DvBXQNeGlGL0qzSEWXMKJjMyzoO2o4alk6JEyNsIz5NsYnLRkUG2lUnxjlRTD3hMFZ1O69HD5w3nrJphJqNU950zozpJY+0j3G3/AFSPrwL9cald7O8K8yPhMnNaxBQNx/hacHUGX6vxlC7kVdmNUbci+Wk0leBzyrZhRM+zuGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzIk6kJtLUE9kzb48sPhXI5DHBHAcxwAF8t1l18sDfo=;
 b=t297HHPN7786BxjbjAN9qHPklXpSW6pPFwHJGMgFX1LsepHwIImLDb/5GG2VJX7C6s6HZqc6TMZ6izkQ6d0oH9sCSdkf5qCVabHECt0HLMINJp29e8gvdTu1L95BWaVFVajGX9lXcYms/2xGJfuPSLQTickeUFq3aKfihXrr8JsDBKOQiVUc8OSy7PSsCo1YYCUgKlIKuI9Uj25Ac6B1wALCvheqBs2MNYoVn/GBPFnoeXnmpiENlX7j+m+FlhRukirI95LsjVm1/2OhjA+lz6xddVTNtkeE/h+Tgkt/6BC1i23ofue5h4H0SrALEh2lLmZ9vVerNUTOgd7tHiSHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 09:34:40 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 09:34:39 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Hidayath Khan <hidayath@linux.ibm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "horms@kernel.org" <horms@kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wintera@linux.ibm.com"
	<wintera@linux.ibm.com>, "twinkler@linux.ibm.com" <twinkler@linux.ibm.com>,
	"heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>
Subject: RE: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
Thread-Topic: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
Thread-Index: AQHdD9iMFy+KzXkWFUSXG5MLgXbKTbZmfhRg
Date: Fri, 10 Jul 2026 09:34:39 +0000
Message-ID: <PH0PR11MB590247B1CA37A1E9A4B4FD79F0FD2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260709191732.124092-1-hidayath@linux.ibm.com>
In-Reply-To: <20260709191732.124092-1-hidayath@linux.ibm.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 5f5de6ae-0ea2-4438-3085-08dede66770d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: VYsnmiUTvgAMimx/YKNJM4vs2YnTeIwEtYhQQcY2rvhEXQ891bBu0uM+c5WyMAbpJjR9iHaueRuyMRqyCl1+RmzLKZvqeRUcqt8EAOt7RYKoC6sdY8vHBmtrSXzzWCUTWKwOXkcY8mqmglF7dUXwB/GsmyBQLJkRqPywM5mlE9tPzOx1wMnWUisDfFdpn/cMNspOiYAA5II7WE07s5JqTS53V1nosKPvlIAea3jKhtLULU1mdttBqYzPhBMvdhrXRVEdDM1vWUyVeoAdmEYgowBg2AFN5s5kvbk+IkqNozu6gNUwO88yvznQ6Lq5JuZw03n1rP+tGmHbG0HCT2aHuFUw/RLc+7G3UmZb7hB3oKfB/Wl7E20gz/XcGK6HW2r7+GvlPF7GuPJbSSXFLOPQW9OrUvpW81OC0+I5abRIaGi/e01SQVxaAN9HK6/AojmIWY9iuHVLozvn3O+yohAmIjzAEFG414xKixu6UJnk+4zoOfPdjr3NSTRp1NXPAaW8alE6jjq7nF3nZPB088IJAGXDfCpMjyGNB3XQTndZfj1ekVyJXrRgN7T4WJnN/b9Gu8dm/s4m0niHL4Fleah+IF764Uw6lr80jsecoUXdpZzF0j3tNPXMkifJInVvjAWdKNbQUL5d0mriuk+COnGtAi2HIs5MXXJFS+au53ox2dJG0RxbTSqdXtR9iDad+A0IKdTQrFxbjOuZiXorybdH2dX4RaHOBIrHeLXY4X1lgnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C6cmZi28P0YahRzc9FtGGVPhRHqb873kWdjSutbdQC4cigS88Q+QXfzJhZFb?=
 =?us-ascii?Q?hMMM706qY5+lBagN4Nbs0mLpHCyZccMf31zDpCkGIgdavY4NJRD1gKXX0ju/?=
 =?us-ascii?Q?/CdW4gALw7Ls3UDBucZZsewvMZnoj04k+d16mNr8eDuvIi+W8AvpOiaAd0iY?=
 =?us-ascii?Q?7gXtVn3TBT3hE4SVOCJd2rAium/hIXGbTJqg5liwJln2iG5ygeWogpnZz03x?=
 =?us-ascii?Q?5SMZ9hcsK0I4oxsVzhFrRTAoR+cLBYe0+SalXq3QZWNl9N/ZzHt0oV0rAcqh?=
 =?us-ascii?Q?0pTIWANEMiNQ9USdp4evf2PUfu59MXyDIsTs2mxzXrMo+M2rcjX6HHTE031c?=
 =?us-ascii?Q?BtQifLCUZzGRPz4Riq9CXsT7EkN9iJ44He3OA0/lN1f5MM8FnF1fc5TzzohT?=
 =?us-ascii?Q?gneGsA6tI2NtyUK+erScnIU/vGBYeCs8VoDhCab6xCoIG3O48MjoJNAeksmx?=
 =?us-ascii?Q?LxXTRBefEfQ4n+2BHbGbV+KqKFxc2SVCy7VXzZ9DOK/Gi9f1J44xOIWumi1F?=
 =?us-ascii?Q?bwgZYcn5mQxuNeOcwET173j7XJsJQZionNXgKi8PxWPYAUWw8MQInGmB8Rr7?=
 =?us-ascii?Q?Ot+I5RSB8NQ9qJ3ixOg+WFlA3PnK3Ojcl4X1sj49wmDUqmMd0K2Ar8IPV8vh?=
 =?us-ascii?Q?Y/QjLE8X0RS72xVoYQHzfcD7GN3W/iiH30WREZ1gZoULvsMtqIhVGlMhIV1q?=
 =?us-ascii?Q?nZHrkezkh7+jX1Z0tH7WGUBZFG6YpgkP3MUc3ma+SaRjZqYVBd4JtzDuuzgK?=
 =?us-ascii?Q?zZCsL+kz95xcM2RvhBPdhtApWROMWA8AmwxepVofVmtejPINCt5xET73R9AB?=
 =?us-ascii?Q?O0aF9ztMR1iK7dl7ZadA+x8T40H7XYPvHgFDwGGyStGskLOuZobVF5JSXo0n?=
 =?us-ascii?Q?b9OECCFefLB7cSsmiQMiV0Lb0TXSB0AwGGxQeubxopf3vTJzMp2aXHQnjFkg?=
 =?us-ascii?Q?MB8zkmrD5P0m6CYXprP1IiXbwekWYAKjlQL6jfpeHIktwpi/t0lZu0+dXp7M?=
 =?us-ascii?Q?TBhQARTrg7bIrcFy+eRX4HwxmKYEpQDqfYKSaxLDbheff3dBcrs8BS52a3Tv?=
 =?us-ascii?Q?tUazT9waz6kjuxeHVg2qm7hmkFCo6ITWJXvUFhTNm7mTeg4abvDwraYHzgxK?=
 =?us-ascii?Q?LMWVSqplFU2y0f0n72G/rOn3Ny6h9Nj3yFbKlMGixK4vEfpYyqDg+0ZcNsyd?=
 =?us-ascii?Q?D3r+nMe0uhySXqfMXmPKNTN698GPFXX2UYjhaOn/tOCRKPT3dK2MqUL8mORa?=
 =?us-ascii?Q?hBq084xHCX6Z3qXAwZMQzSTdwK/zvlfFM+WFEvO+kqY6oGm4GqBuL08mru5D?=
 =?us-ascii?Q?bGqIUg/hVEhRmZmI0mQswBEqqZ5hbYjGgqWm167qShVw8+sHEzYOkbZ9mpco?=
 =?us-ascii?Q?XlTz+WqXzcDxGPC8fRkfuNj4RMOg0Q/BU/Hb4WD9rOs+2gbt8f1hANmQG695?=
 =?us-ascii?Q?Po28NSBwpYOFqXVbnJaQVJuaF/8XcPjWy9qLPSnBkyrmbBbLoclIXSXdhaJE?=
 =?us-ascii?Q?v2HplaEMsc8FoWI4V46MXevT0mjN5i0fV/N9eAj1AS05Jc5hj31kLzNVUyT7?=
 =?us-ascii?Q?Kiv2O9qhXxpSqQ0G/jC5bNI797LTT8Lz7qbJGShmM08WtJwqqK64T3BqZb5Q?=
 =?us-ascii?Q?b8hiwtxXPtnpyRyVJlMRjLu2i0PVDyAWg0pJA8b7KEXJfUCzYwVmitGvOrXr?=
 =?us-ascii?Q?r76z6MvaSxHSPrc4gkofPuB5C1MeTJYRw95W974j7wle2IaWxZrQgzmuBzEQ?=
 =?us-ascii?Q?CSnYhP5XwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H+gra6gHx8rqUPwQrcnwucJsuxlSjv2fWdI7F5aa3TZATf33ZwTWYEMYN1I8FGdNdZUSItk7JKbER845F6RKYN4yM3xyXrwFbbaFlnUXXFVIsB3UYw7T+Ms8lDU5+Cr3Akykr6aJskim/ANVDHbLC0uf9HkPLMKy/vMviQZ+LOUNxOGjnivRftfNf7nrEie2moBWtc6zKD5cfTh9cgJSsaVrXgC4FBTfBx9cv2YuCA90SqZirzPZxd1tTRFKlpY9gb7f0qtyD9ryomyggI8dvz/wVn/F8Y2b9TH2VjaXC1Zf05aHaGksxCYTk6UDXLLmgYvnGClxbhN7TuGOBI1oug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5de6ae-0ea2-4438-3085-08dede66770d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 09:34:39.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqksTs8yzed4F8CcZN2p661iprHk2Oi3h9dAxaj5eVxTVO65N6wog9hAKdQsuQQZzgPUN9uJiQHvWy53+Fzt8lc6D4dezaKaEkCQo4H9ydM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com

From: Hidayath Khan <hidayath@linux.ibm.com>=20
Sent: Thursday, July 9, 2026 9:18 PM

>afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC.
>If the allocation fails, nsk is NULL.
>
>The connection-refused path is entered when the listen state check
>fails, the accept backlog is full, or nsk is NULL. The code
>unconditionally calls iucv_sock_kill(nsk) in that path.
>
>iucv_sock_kill() does not accept a NULL socket pointer and immediately
>dereferences sk via sock_flag(sk, SOCK_ZAPPED). When nsk is NULL,
>calling iucv_sock_kill(nsk) results in a NULL pointer dereference.
>
>Only call iucv_sock_kill() when a child socket was successfully
>allocated.
>
>Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
>Cc: stable@vger.kernel.org
>Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
>---
> net/iucv/af_iucv.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>index fed240b453bd..f5b1ec44b6ae 100644
>--- a/net/iucv/af_iucv.c
>+++ b/net/iucv/af_iucv.c
>@@ -1872,7 +1872,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, s=
truct sk_buff *skb)
> 		afiucv_swap_src_dest(skb);
> 		trans_hdr->flags =3D AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
> 		err =3D dev_queue_xmit(skb);
>-		iucv_sock_kill(nsk);
>+		if (nsk)

Hi Hidayath

why not to move this check into iucv_sock_kill()?
would prevent from potential similar issues in the future

>+			iucv_sock_kill(nsk);
> 		bh_unlock_sock(sk);
> 		goto out;
> 	}
>
>base-commit: 262b2eac463d880a664cf92af1107b4f9d84ad37
>--=20
>2.52.0


