Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAC3B583B;
	Wed, 27 May 2026 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864983; cv=fail; b=Pd4uoSOfObh7nBfMha0cPHuKtBT1mfXNOgXCki7TMyvsrhmi8eVMhkTlD36HK5HRWhz31L57FZ26hFRPC6qYJ6ptR4GwBi1LRBHFou9fJOxXqLh1N5cku57gY/88jMIOmz0EzI2O5bq8M8PktDp+izVc/bXnfv+1XsHTAtLtTPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864983; c=relaxed/simple;
	bh=8h+vD6tn1Ia7uoLGzZmdq2+R6KwUGYGvWoMe4tYQfjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5HW2aFz0fxL7tImjs862iWwsunMTRw71BIS1D01Jni/1jLjC9BjHtgylw8sHDHCqDewolg0V92LP7UB3a++nn36V05sciHzKk2qWW/4Pg8I+wM3xoejZ7I/VNOk6wcoTDdOcu9hm+RvgBrVOHz5+y3TjyupEYmruISNcoTlF5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHG4ZEKa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHG4ZEKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779864982; x=1811400982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8h+vD6tn1Ia7uoLGzZmdq2+R6KwUGYGvWoMe4tYQfjo=;
  b=QHG4ZEKa/fWfJThr/l+rrSS9lxNGjZykg+4NVcmWsRXZ8s5JVy+fcOxk
   RZnpghlTthxHCt2IG55Ok04rIZ0McQ5HiFpjCmFlyFO3NDITUheb9+6yj
   mxXxEIGxKdiTI8GvuQ4jdd0QKHfropqejTItCo3wdxvYF0TxuQDx+cWft
   Hm+doA6NGNTMgjoKzRfujHkYBB7kPwG5amwEcVlKfU8tr1OZU8cjPDUi6
   mG3VjWhQ8uAvrF43NNt9HKdkVr/C2tbKz0ZBP8/4j4PxfIurMuFaB+tuK
   f/iam9uFU6F0eJWs3e6rdu0hI1/SIXQKKy/w+PCYcLXsLVnMDGrOto/M1
   w==;
X-CSE-ConnectionGUID: Yrc6miLCSauD7D+q/LWqJw==
X-CSE-MsgGUID: J13UC5edQDeldeRn1J8ONQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80874619"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80874619"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:56:21 -0700
X-CSE-ConnectionGUID: pCxM1vI5Q8WLYzjFS/HBQQ==
X-CSE-MsgGUID: APlJOW4jSo+OtL8M8IIbWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="235786705"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:56:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:56:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 23:56:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o97TNKsQjPPmjStGL6sN0nW4c79v2iuPEy6zlfrfLEYwa17TrYEtCgn8DDVxArI6nNxvr+3LzDQNSzS8qSqVa1GVfSSAo8nRJsIL8IbMADvtd9w3cz3Yz8LlVlcC4td0ZGFexjgu+GLkvLEc+uvoWfze/8xly43bpKNf4v7dz5e0TNfPfZWj56XkwyGmL0kiR3ZqroEO8Mh7jWCeLviv2GI27dckALUGSvx1AJrVerx9xSLdFccPze3V61o4lJKNsrmtBe9S5+Hod1pUbFTPvbGN/SFeexlSKwLa/k9f0wc7NqjUwVZFD+ezGwwiUkN+BV6+mAb9zblJSNGyGjsTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h+vD6tn1Ia7uoLGzZmdq2+R6KwUGYGvWoMe4tYQfjo=;
 b=n3CpElkvePp/QizXPPfqHdeEJ+hwtQIlvwlRY0BJeDnrd98f2wlbtLTARPNvokDFqTpvnhnZ0XdZOTM5FqI+yCnJ7jOaRlYHdD7RvTtCbLsDQdOmeEZUqf3WIlN2UYfMGXMhtt3oGJJedN97gqFCGEMfWCq9+X8wu55aafSj/+AydV7NTB3fK3IBY9uC6Qbyhx0D5m3EST2iQ0vkq5rOMdDPl0KfsoO4aXyT/LaYoPhwupc/G6lTpxxQLBPtOx9shzx3+zqKkPYaBG3O5/ZUnv8YtRFp6ykWWX7zUggIOtWPQOjtsLMtvMfOpUOtnYuChYHMV7rD8i3oRa43rBjfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by SJ5PPF77ABF615C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::836) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 06:56:17 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 06:56:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>, Alexey Kardashevskiy
	<aik@amd.com>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg
 Roedel" <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Nicolin Chen
	<nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, "Will
 Deacon" <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, "Shameer
 Kolothum" <shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic
	<pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, Holger Dengler
	<dengler@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman
	<farman@linux.ibm.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>
Subject: RE: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Thread-Topic: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Thread-Index: AQHc7F4e17RJh85db0aDel7MBcIAD7YhA0YAgABlFACAAAl0UA==
Date: Wed, 27 May 2026 06:56:17 +0000
Message-ID: <DM6PR11MB3690AC082E231282BE7352038C082@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
In-Reply-To: <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|SJ5PPF77ABF615C:EE_
x-ms-office365-filtering-correlation-id: c03333e2-fd66-4fcd-70cb-08debbbd0ced
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|11063799006|4143699003|38070700021|3023799007|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 1oioqySxnwCtIBvLK+FyRp9XOmYt/aAQAQO8ZwWsXbEub4RhP2T6mLfumk1y1mMrxvOxbOnwMFLwy+2sozbQGyl5tNwn9VLFbSlVRNisADqt10nYmyWLAQveK4oW03E5SsW7Ik6w+k56+No1FXIhL2CU6RwcdbpR9Xak1sTV9EZE2UA3qx6FovIZ692zS0d32ZnYKrVt6dgFEbV/AZ5vJeAuOSxUO8OIyC9dqDSjWB8+Lb5gfLzzp1wmepK2GTm5GnurUK5utdVeTPpFAfXXsvqMLTyF8A1rdSoHi8HO0TefuUCZTL5GtxJESJvzwLQJQLIZe94E4eYSgoDzPimHWgftVxmXi6+Xrd/VUNPpW/okYgtW9hzovRgLzSdVNCnk/09HrCQq4hyCMCo3ZpH90bBVePGi3x8hpZFHz7bMHVl/X3IX9rnsmU4hd7a5vNmQQgIMOaH1lMRwnut4qLVSdRjl6B+QTYPrzd+r/aiI9XuoY/73tGetisCHCAMotKCYr3JKCzUg5yvMf2yPmGjFQVKNf8P9LSBgLtrupr41lBuBQ/hDsOcaa7blgg+MktZVW+QhAiHn03cwURYKAZCgk8arVj4aeTM64Mh4PHFNjgOuPy6E/HpdpQHFUijVHAw7vMxbEuVP6y+Zvfbam1DNDXh1fZooBgpPvZ/fojT9ojiscZvNEivJoDTycAnaBt/JYcdKx3ILdN1kP8hQSVg8DHt80wCcAgBAY9LdBT7erJwwsqKALhSQjE3Mkq7GlmuS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(11063799006)(4143699003)(38070700021)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTFObjNBQVZnSEFJVEpqT3JvdFpUWWk5Zy90WUVxVUx2NmpIai93aXRrYnBT?=
 =?utf-8?B?aWFTUVpCbXVKalFnajZGdUpwVURjU3lkWms5enJiWXBqWHVVTmoyaHdnTGUr?=
 =?utf-8?B?Z3hpTHFzQlZLaXBCbXQzYjVKSGlNM1EvY3plbGFmYkVOR2ZvSDJXWFJ3aTVK?=
 =?utf-8?B?OERjTzViUTQ4VitwS3VqWmtSc3NyQmxSOHY1Z0IxWHhYdmJvSjR3NzVzUUJy?=
 =?utf-8?B?L2xSYmpYOWdXVjRNaUhLT3pXOGVwTmdzbjNiK2JBUzV5MmhWRTIxSFhXbmt0?=
 =?utf-8?B?WHJsMHJocTBnTDFhNm5YTDdITlJRdEJxYXRJS0FTSGRVMXlVbFljRHNtbU1I?=
 =?utf-8?B?ZVQ3cktZcDBHWVk0aTYvMm9rOU1BV0FTUk5CaUw2dHNoVy9iZ2FWMCs5NVhP?=
 =?utf-8?B?MW4yQ2JKcHErRmcwcFVtYU5USUFZTkY0UmZMRkVQZTMzYnNQdDNQcnJhM1lL?=
 =?utf-8?B?WWlCOTVLRTdIM2oxdmwvWnpnL0xrRTNwYVM2Tm9KQXVBdHkrTEpGZTFDYzBW?=
 =?utf-8?B?UHJjMWgvT1lyUXdaY3gwajdSSys2T3FNZ09kSFZsY2pkb2JMWHphVnh5L2xw?=
 =?utf-8?B?eEhQcUtzekRCSDVGMVdrQ3J5Yk9mbGhIZ2gzcmxUUTRWbGdvUlNTdVlNMHJr?=
 =?utf-8?B?eG5DL3NKZE9GM0c4NEUyS0dQUnA2cjI1ak80RE1lWXR3Z043WVdUZzVIUVc5?=
 =?utf-8?B?ZEZpcW1xOXJLTW9yYkFFS01kaWcyLy9KQTRGZ1RJaEI4cjNIaXN1M1hsTk0v?=
 =?utf-8?B?N3ZUMWtyeTFCcmVBOXRsekNwa2VaMU53WXlZcEUrVWpWNUI4ZCtVTWZ5T0hZ?=
 =?utf-8?B?YUtteHRnUXZpSVh5YUo1MUxuME5nL0pFWUQ4THdhMVJKWnBoV05rQ3VHT0Zr?=
 =?utf-8?B?MERJN1pnZmlwV1c3U3YyQVg0U2x0bCtiVzRuMkREdmIwNlN0NUZ3WFB4SFRR?=
 =?utf-8?B?cXlWWDVhNDFxTzl3VlB0c1VmRStYdXR3enU0UG1ZNVRtcmVHNFNDU3JUVng5?=
 =?utf-8?B?bndMYUREVkdRSVpEY2liMjB2T2tNdlBqNHJkUXFPeVd3ZFgwRW9IUnhDb2x4?=
 =?utf-8?B?c1VDWkRmQ3RsZWtBblNxdHdYVngzMkpOMUV5VmNGME9JVDhKUDQ1Ynd0cmxZ?=
 =?utf-8?B?a3hNMUp6S3FHUkYxY3VwNEI0SWtOM2dKelR1Q1RNMW4xZ1Npd3RncTlZdXJP?=
 =?utf-8?B?RTJIbm5wcjBUc3grQnNmRHJxek5waS9JeXcvZUxXTWZDOGVQZDlLZEkrRVp5?=
 =?utf-8?B?VDJEcmVhZUkwaUVFbXMrWS8zbzA3YVZ5SnAzb2lYbURNOWdqRXJjdFNYREI0?=
 =?utf-8?B?VjVYU3lSUlQ4TkFrQUluNm9DMnYxQmR5ajU5T3hYVVNsUTdVQWU5cGRmejc4?=
 =?utf-8?B?RjB2VkVtWUVHeEFRd1MxV1dTQ0k2UXUvNmlyMG52QzIxUEJubWZGblI5NW5u?=
 =?utf-8?B?Tyt5bkhXNEZyQW1JNkZQUXFNY3ZocXBhY3grMlJzQkgrQ0UrN1I1UHZ3bnYw?=
 =?utf-8?B?TWFTaDJyUEdYdGhvYXVjWUJpK0YrRG4wWnpYTE5VNURwZmJHOGxlUWIzR21a?=
 =?utf-8?B?UlFmU2p2QkdqMHVLTnJjbnRucmhwYUtOYS9HT1hLcTBUMHRxZUhZQVRIamR5?=
 =?utf-8?B?TDFPbFZqQzV5SDhxMFZpYXJramZmdHZDbUFXaUppcFYva24vbGl0QnhxQTI5?=
 =?utf-8?B?bWc3aTdwSmF5bU01TTlSVFFvV2VuakhvdGJlVy9rR1dzUGVwRnY5NmQ1SGtt?=
 =?utf-8?B?eUtMa202bVZ3V1k1eUpwMm1iNXBzUUZHUmhsSk9KUGx5MnZKMXZ2M1A1RkVL?=
 =?utf-8?B?VllDc0hCb3JibktJZ2hIYTFlRTJIMTdUYW5DK1hCRmM4MlRLUlJ1bWRpYThz?=
 =?utf-8?B?czRkeWl1YkdXbzh2eitwM2Nya0ZhdlJ5S1ZRVlMxc2lqbXluZS9VZk5oa0w3?=
 =?utf-8?B?Zy93RjRFNnRDSmhJTktQbDA0SU9wTnBNOERrYy9Mc2gwYUhnMmMwb3ZIYVNa?=
 =?utf-8?B?YUZFcStvd001aTJIaG1DY3FmNFA3ZTRkSWk5OTR5czRRN3RMNjJZckFBaWl6?=
 =?utf-8?B?S0NWbDAyY2JLYVk5Q0x6V3c4MEx4cVh2MzRITWpJMnRkbUttUS81NVdJVlhl?=
 =?utf-8?B?czFuWXU5ZXVNUURJY1BNdWMvbU9QWDdqU1UwTGFmci9BSThTUzFqNkN0bnlq?=
 =?utf-8?B?MmxYNnBXSzA0WnlpVkRidGFZVTh1K0VBWk1tZ2VtNWdNK1pHdzh6SnducDhk?=
 =?utf-8?B?bGFUV29Bem1yVXpCZXFBQnR0LzFiZGVsZEplOW0yc0FmSVJTRitxcnFJb1Rl?=
 =?utf-8?B?NW9nbEkvcG5qdlluS0N4Y1RGeitPOGdIRGF0RDc3eHRjMkxGb1FSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KiusO7FsVyHqrFUxm3UEWF48W1YL/KFUDFC1jHhCXC+ZiRAwJ+LsNt4uGfDJu69jtFD1A7uzAS8nb7CP7noQg6pEz/oDez9xL15WaEOidgVzARvVCIY4YsYJpvAFgvzHdacQLgM9nnyfG1teVXENxsco8W1xrsD3/8VXwpKCYHnqmuSWuLkWOFUv1mK8Enm105YlTVdG12RR29kOioXjcwsj6LlmyGeLhLq4+Wsae+wLGXPtfMxnXt8tywI24zUz4u2DZzDIbmwUbTTjA25LDcAuCys4HQyZ266S85apUcfSjYEuNd40U6VEe4jzUhwx/E/e18FYW2McxldQC1FG3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03333e2-fd66-4fcd-70cb-08debbbd0ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 06:56:17.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDvovSZZRJFJyIwTh84avqPcp6DnJx5W3PzcsjfRIem7DJ0cm+NkJ20NDYRyBnV+4cybHVO8gAzP1KVccWoefw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77ABF615C
X-OriginatorOrg: intel.com

PiBGcm9tOiBEYW4gV2lsbGlhbXMgKG52aWRpYSkgPGRqYndAa2VybmVsLm9yZz4NCj4gU2VudDog
V2VkbmVzZGF5LCBNYXkgMjcsIDIwMjYgMjoxOCBQTQ0KPiANCj4gQWxleGV5IEthcmRhc2hldnNr
aXkgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDI2LzUvMjYgMDE6NDgsIEFuZWVzaCBLdW1hciBL
LlYgKEFybSkgd3JvdGU6DQo+ID4gPiArc3RhdGljIGJvb2wgaW9tbXVmZF92ZGV2aWNlX3RzbV9y
ZXFfc2NvcGVfdmFsaWQodTMyIHNjb3BlKQ0KPiA+ID4gK3sNCj4gPiA+ICsJaWYgKHNjb3BlID4g
SU9NTVVfVkRFVklDRV9UU01fUkVRX1NDT1BFX1BDSV9MQVNUKQ0KPiA+ID4gKwkJcmV0dXJuIGZh
bHNlOw0KPiA+ID4gKw0KPiA+ID4gKwlzd2l0Y2ggKHNjb3BlKSB7DQo+ID4gPiArCWNhc2UgSU9N
TVVfVkRFVklDRV9UU01fUkVRX1BDSV9JTkZPOg0KPiA+ID4gKwljYXNlIElPTU1VX1ZERVZJQ0Vf
VFNNX1JFUV9QQ0lfU1RBVEVfQ0hBTkdFOg0KPiA+ID4gKwljYXNlIElPTU1VX1ZERVZJQ0VfVFNN
X1JFUV9QQ0lfREVCVUdfUkVBRDoNCj4gPiA+ICsJY2FzZSBJT01NVV9WREVWSUNFX1RTTV9SRVFf
UENJX0RFQlVHX1dSSVRFOg0KPiA+DQo+ID4gVGhpcyBzY29wZSB0aGluZyBzdGlsbCBuZWVkcyBj
bGFyaWZpY2F0aW9uLg0KPiA+DQo+ID4gSSBoYXZlIDMgdHlwZXMgb2YgcmVxdWVzdHMgdG8gZml0
IGhlcmUsIGFsbCBnbyB2aWEgVk0gLT4gS1ZNIC0+IFFFTVUgLT4NCj4gSU9NTVVGRCAtPiBUU00u
DQo+ID4NCj4gPiAxKSBiaW5kL3VuYmluZCBUREkgPC0gbW92ZXMgdG8gQ09ORklHX0xPQ0tFRCwg
dGhpcyBpcyAiT1AiOw0KPiA+IDIpIHN0YXJ0L3N0b3AgVERJIDwtIG1vdmVzIHRvIFJVTiwgdGhp
cyBpcyAiR1IiPyBSaWdodCBub3cgSSByb3V0ZSBpdCB2aWEgIk9QIjsNCj4gPiAzKSBlbmFibGUv
ZGlzYWJsZSBNTUlPL0RNQSA8LSBubyBUREkgc3RhdGUgY2hhbmdlLCB0aGlzIGlzICJHUiIgYnV0
DQo+IHdoaWNoIHNjb3BlIGlzIGl0IGhlcmU/DQo+IA0KPiBUaGUgc2NvcGUgcGFyYW1ldGVyIHdh
cyBtZWFudCB0byBlbnVtZXJhdGUgYSBzZWN1cml0eSBtb2RlbCBmb3IgY2xhc3Nlcw0KPiBvZiBj
b21tYW5kcyB0aGF0IGFyZSBvdGhlcndpc2Ugb3BhcXVlIHRvIHRoZSBrZXJuZWwuIEhvd2V2ZXIs
IG5vbmUgb2YNCj4gdGhlIGNvbW1hbmRzIHdlIGFyZSB0YXJnZXRpbmcgYXJlIG9wYXF1ZSAocHJp
dmF0ZSBzcGVjaWZpY2F0aW9uIHdpdGgNCj4gdW5rbm93biBlZmZlY3QpLiBJdCBub3cgdHVybnMg
b3V0IHRoZXJlIGlzIG5vIHJvbGUgZm9yIEBzY29wZSBmb3INCj4gc2VjdXJpdHkuDQoNCnllYWgs
IEkgaGF2ZW4ndCBzdWNjZWVkZWQgb24gZmlndXJpbmcgb3V0IHRoYXQgcm9sZSBmb3Igbm93LiBJ
dCBzb3VuZHMgYW4NCnVubmVjZXNzYXJ5IGFic3RyYWN0aW9uIGFza2luZyB2ZW5kb3Igc3BlY2lm
aWMgY29kZSB0byB0cmFuc2xhdGUgaXRzDQpjb21tYW5kIGludG8gb3BhcXVlIHRoZW4gaW4gdGhl
IGVuZCB3ZSBnbyBiYWNrIHRvIHRoZSB2ZW5kb3IgY29kZQ0KdG8gZGVjaWRlIHRoZSBzZWN1cml0
eSBzY29wZSBvZiB0aGF0IG9wYXF1ZS4NCg0KWy4uLl0NCj4gLi4ub3IganVzdCBvYnNlcnZlIHRo
YXQgcGVyIENDIGFyY2ggY29tbWFuZHMgYXJlIG5lZWRlZCB0byBzZXR1cCB0aGUgVk0NCj4gc28g
cGVyIENDIGFyY2ggY29tbWFuZHMgYXJlIG5lZWRlZCB0byBtYXJzaGFsIGRldmljZSBhc3NpZ25t
ZW50IHN1cHBvcnQNCj4gcmVxdWVzdHMuDQo+IA0KPiBJbiB0aGF0IGNhc2UgcGNpX3RzbV9yZXFf
c2NvcGUgYmVjb21lcyB0c21fcmVxX3R5cGUgYW5kIGlzIGp1c3Q6DQo+IA0KPiBUU01fUkVRX1RZ
UEVfQ0NBDQo+IFRTTV9SRVFfVFlQRV9TRVYNCj4gVFNNX1JFUV9UWVBFX1REWA0KPiANCj4gSSBh
bSBsZWFuaW5nIHRvd2FyZHMgdGhlIGxhdHRlciBhdCB0aGlzIHBvaW50Lg0KDQorMQ0K
