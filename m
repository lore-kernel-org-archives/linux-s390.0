Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6A22087;
	Tue, 10 Dec 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838919; cv=fail; b=k/Au+A1+GLpPS9RDupJg869hFjT+fdytKhvqNx+L0vij0QZAITUUx3ogf91B/HsfItD5yJM5U7cgaT/MmlK/9cSKGREP/bB7oHlLfn06gK3KSdw9uB4sTcPMzZ2E3W+IKyWFDJI/QmDXBhq2a8lzpj/5RN6kSvyJnKggP6xyJSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838919; c=relaxed/simple;
	bh=bxkm8RTySRWVf13iQ3UJhubVD1I5S6mfmICi4SxBxqo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WXcnKb3LxjGNJIyGZYkibsL0zL/nbcb8o+XGUariU4cneHKgwCDj59+o7Axjk1HgTN+PRN+XRPYI19o9bE0qiXr9vPeWeloG3d4PeZZIDNzkXp/Kt+PbZjfPEV5Gq+3lehH5A25zmN0RcWi7K3scCe6h6uHlBuf8vZd8kFf2WiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gcp1Z/n7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gcp1Z/n7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733838918; x=1765374918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bxkm8RTySRWVf13iQ3UJhubVD1I5S6mfmICi4SxBxqo=;
  b=Gcp1Z/n78Z3auejJsHI6DOn9wYstYYyJco1/e0mmzR3ZaQAca8S2ammr
   //DeKEZ3k7MpyVPE0t2n1g8j5nO1y1lyH7ImcIACpCehPtEmilV1C9VgB
   C7sZWI6lLXEcmA0KyoE9zD8ckKEjkMt5nMufVHd4UVWZbpY4ZMgw5pswA
   9qplXymGzf6UCRaJa0oRRmyiJ+ATyiCiwaaiQTZS2qN9tSHzO3BMXObpt
   XX9P8V2sWzoxRqwCTdL0vZDZ00CaNcX6TG+9v4qSGw8eICHwiWj6ILaFE
   +O/pN4ID/QWlHQe/H9/5TQ92j9FuARvPXEURa0J1XcayxXqbd/oHRr67u
   A==;
X-CSE-ConnectionGUID: dvqdGRXeRBCIQE9golLLyw==
X-CSE-MsgGUID: EHKc4KFwQCS0NEE2wHPa/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37867297"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="37867297"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 05:55:17 -0800
X-CSE-ConnectionGUID: doirFSKhSD6B9Z7xaJE4Gw==
X-CSE-MsgGUID: LV2fj4hoRI+KD53zNmO+7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95471404"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 05:55:17 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 05:55:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 05:55:16 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 05:55:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDU407GDA729hWghOo11yW4AZMW4Pk9+p28ETR04W5eMnxsOju6tMHjvXsBdUFggGOAARtOWROMHyrwZ96DtEEhOEQ6TY4MH/37JhkAPkYejRXvaMefIPPY91dOfSoz5MLAI/6SEEf7csNdF67S+mz4B2mBShz6we2jIuTz/pWXsIzJW7Qdnnt9WT+ajnvsWa3W35Re9u+LCdS7MTw3MWDWzedM1w7CeUFdDTsOqU0R6wxGhZ4FmPcmZpwe9XMUUffvGJJUvwbqnUVweKkGK6hrJUpsSxswAvZLj8IW19ZuTtm7Ux/7NvaX2iXMKtM8vtx7SZ5S2b8qUYsHsk0PH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2TG4KqZi0Mlkmtrv/5SijgnaUTuFdg65oUflWmeeeg=;
 b=CuVV33RGCZpWXiapkPk/fbVezn/hIL24Ah/hE6r9Le/M8pH8gFKuX57Zu9qbKirKAsnRdfyncDKvM9hcPtU55jmk6tD3Gmy4kN6qb7BXpLNCmkdypyncw3SpONNKYTddL+aMMDDMcYKFx78JSUv06JJPZslBhNh3c2uJDWDa+djD/SWlXYFLM6FHj3evy1S+XE18bexVA7cXSbxeRUevJre0gcbIGxL9kEWugvi02KmbUYZmXnVXsbEk2N8pcyLu6UoyLC+27oIU5sXsQb4G8LSjuSQbVeyHCrGHOwLth+rb1lqopaNA5+QDeTCMP5XzPJ10mA3CdOM5byrzUubn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.21; Tue, 10 Dec
 2024 13:55:13 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 13:55:13 +0000
Message-ID: <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>
Date: Tue, 10 Dec 2024 14:54:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Dragos Tatulea <dtatulea@nvidia.com>
CC: Alexandra Winter <wintera@linux.ibm.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Nils Hoppmann <niho@linux.ibm.com>,
	<netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thorsten Winkler
	<twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
 <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea847ca-d70c-4c3e-776f-08dd192244f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ai85dG01L0tMWk00V2Y4TGEvYzBNZmlpTjdXc1pZeVZ2SnhnVXFDRHViTllY?=
 =?utf-8?B?TmsrVFRlS1kybW5xN0U2SkpUTDMydkhET0dRSzVGWTI5OW9nbTZuU3Bac1RF?=
 =?utf-8?B?by8veng4Q0JHWGlLbGJFLzBvOHA3Y0hmbVBvT0d4K01MaFNCZXlRcHpQUVBI?=
 =?utf-8?B?U3ZVWmZBNkxGM3p5ZlZkeWNrbFFHWlNlNUVZVlNoYjR6aXQyNy9xWElmZEU5?=
 =?utf-8?B?eHl2dzcvSU10M0hnYy9UN3Z2bmEwMk00QW5VK2RrUVJROU5FN1M5bkhyMTVq?=
 =?utf-8?B?UHB0L1JIcmxaL2t3MjBMMzAvOGdHYnRKV0dVcFZsQWpkaG1Gb2hkVnIvZkRE?=
 =?utf-8?B?TFN5UGMyc0pSNXhCMStabGU5MFVwZFV1cnc1WERwSXJyVldlcUJJa1pGOE5V?=
 =?utf-8?B?aml4bTFXejdoNXphNHVHM2RyaWxzdlRqd2dma3FQckl4YVhxTkg5QUtGVVM4?=
 =?utf-8?B?QmlsNDdSL0hwaGw3QkpQbUJRc2VSOTVyaGp6ZEorNDhRQW5BemtKbG1LbUgy?=
 =?utf-8?B?S1lPRHo0MXRVaGlWWlRBVnVzNlZraFFFcDUrdnl1TFVwaTBIMTZ3cTdlU1Qy?=
 =?utf-8?B?NTIvMTBqMHZiK0tZYXlsVnVveTBpMzdKYUNpM09jN2Uxa1k1clV6NEI4ek1i?=
 =?utf-8?B?N1JJUm5zN0hqZ0RHYU5GbVdTVk9KMFBYMk9UWkhkR1I3VGxVVW5wa3p5cXJS?=
 =?utf-8?B?TFY4alJ2cTFLMkNoazdLUTk1Z2lWaHdzWkIxYjJGZm5BUUxFNVFQQmZCbXJ2?=
 =?utf-8?B?dWc4eThJZXFXQmxVVktOUFlITG5uWnc2ZGZrMW1YUk9UQWdzNDlPTzN2QkVr?=
 =?utf-8?B?bXBlazBIUHZzdmRRb1JZSkZhQ3p4WHRIM2Q5QU55OWJIQ2tXK2NtVTBnMlZ3?=
 =?utf-8?B?VkhJV3VSMG5YL1o2MThRbzBhYitKc2t3cmRyRW5iaGREZ0laVm9VaWgzL3pk?=
 =?utf-8?B?MTkwWDdhK0pobXE5UmZBQi9laStKMmFaTTlHdHZweFNyZ0ZyYlhWWGI3bUlt?=
 =?utf-8?B?RzRWY0xBME5LN1dORm9JcytMZVZwR1FmSzk5NXg2c1VJMHE1dVBOTG5KcFVX?=
 =?utf-8?B?ZTQ4ZW9UWURIOFRTUWtyRzVQRmRrQXQ1TEFHVDl6UCt6QlFJYVQzclpDTThJ?=
 =?utf-8?B?eG52ZmkxQXpneko3emlvQm9nSGVnSmpxVkVqUUpCVnF1NFRtRG9kSkpTUjM1?=
 =?utf-8?B?TEZwSzl3cncyNG5ZekF0UjUzOTBiVVZpMGhZVUdCL3l2eHRHMlJKeDh3cWhu?=
 =?utf-8?B?Y1N5dG9HR0daYkoxV0krV0tRblpOcjY5dXRsRWR2WjRzMFRaRnRmWEZKbnox?=
 =?utf-8?B?ZFlVWTFWWEx3dGEyNGIxUStuS1RONlBDSUVQZ1pTR3RsWWRjRzk1YWYvOG5r?=
 =?utf-8?B?bTA5ZFI1NjRWTExRc3dzR3o5OWl4OTBMbTFWUVVyNjZhWmxwcTN0ZUt2R3F5?=
 =?utf-8?B?UThzbDJqMGpseFNVQVNGZkRuMEhmeENKM2RSeWNnVmEwUlFHcSthOUU0KzdK?=
 =?utf-8?B?Zy9PUVNxVEt3UzVORiswdDlzd0dXS0N3azdkUjVCaXVHTEY0VmtPMU00WnJx?=
 =?utf-8?B?MlRXNWU1QkFqaENhb3lhZXlCaFVzR2ZkZHRMK2JPNTZmbVNLWmtLK2lkeWcw?=
 =?utf-8?B?Y3grai9hdDJlbEpDOEUwT3kvc2czN2s2dEVaQ0FVNDhGM1RBSDRlRktmVWxW?=
 =?utf-8?B?UVNjRHBUNWo5VjVCdEVJc1dqQ3Zkb1BuSXJJTEhOSlZXZzRDTzNkemwyWHgy?=
 =?utf-8?B?UzhXOGFWa2hWdkRCSlpFTGp0aExrRWtBdkw4cWMwNjlncVZORDVHZDliUjh1?=
 =?utf-8?B?OWhrbGx5czdIS3RZbXh1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpEcEVUZjNpUjlYQ3QyS2pYZjN2Z0dHMnFSSXN3Z3R3aU8yY0ljeUdlRE5K?=
 =?utf-8?B?ZjZKd0dPck9ac1JoN2I3eHcwQ1N4Qzg5ZnIvc0lsNnpzTytEditpbHNtcUxu?=
 =?utf-8?B?aVI4eCt0UlFJaWFJcWZFdmpWQzRpMVZOYTRhYkswbW1ZV2hIVk1sNUxuZ3N2?=
 =?utf-8?B?YzZ3eGM1UkphVDhBb2NubW9ZcFhSaHNTRThWTTNmTTVuQzZYRUdNNUJheXBE?=
 =?utf-8?B?TWF1eTR0TkkzOFlZemxVRjJXcks1REZZbklRTzdHUFBZUENzSjd1MWJ2Y2FK?=
 =?utf-8?B?MEhUMUFtS3pDczQ1UUhRSGNNamxpdVl6N3dtU2VTdWQ2SGpDb2tnUUZwak50?=
 =?utf-8?B?SHJwMTRtdlpIcFBwSFM1S1NBeDJEaWVzMlFmRFNUbzAveXdzWWdLRkNqTzBD?=
 =?utf-8?B?MDJUd0pzcVJVRGljMW9hVGJPRmlwUUQ4K21uMzJkU0NrSjc5Ty9QaFJyOGZI?=
 =?utf-8?B?K2hjVElZRGRYMlV0TVQ2UW1ldWR2V3U3RWwzbG9ieXhUQ1J0UW9KYkh6MkZq?=
 =?utf-8?B?ZE5iSHdmTUtmQm01U2h6NTQxQTA5VktMS1ZhY21RblhNMDZLVjl6dVFvN050?=
 =?utf-8?B?WUdMN3R3RFZYek1SMllzdXVqcGxjcFI0NkljUFg5RmthUThDamRsK2w0YXFZ?=
 =?utf-8?B?cXNYbGhzcVM1dElxTHZhYnBBR2lEMmllRUJVUEFIMmJkTnZaVEJ6NHBoZDhW?=
 =?utf-8?B?VnJGbzA2bkNWem1BUTUzSHExSGV2ZFRuU0YrS09zUW1FR3RjSDRCS2M0ZTJJ?=
 =?utf-8?B?bE0vUHdOL0pXSCtiZEtOZlY0cVVsTEwrdmRNY1pvVHB5Y1pmb0FibE83aWI1?=
 =?utf-8?B?T3hGVEUrbm9pSm1ndmFza2tMWS9lZk01OU9GUk8xdW1YUDVubXYrZ2NlcFNE?=
 =?utf-8?B?cHBjSFEwMm5UNUZTdU5vWERyMmMwZzY2VSt3ZFlPNkZiQWZtL3Vka0tpREYz?=
 =?utf-8?B?cXBoelBXRWxzemxxMm1YZUI1UVZ5a1dNV0JmODVwZHBFODZrUHZQK2tYQy84?=
 =?utf-8?B?cmNqNHBpZnlIREpuTnU0RVVIQlN4YWdONldkUlBXcjdjZ0wvSTFZWWFTc3cz?=
 =?utf-8?B?T3RkOVZkWTB5Q2YrYXpvOTZHSzJXM2Nod0dRT0lTNHVvOGtEQlg0U1U0NGZt?=
 =?utf-8?B?TWFPU2ltNGFzTFp6dWRzelY3NE9DVi85TzUzdWRPSS9LZUxuK0dGMHU4NC80?=
 =?utf-8?B?NEFGKzNvNTZ0R3o2amdoNzlaMnQ4bC9YUkZxK1Q4UUp3a3BIUk9LZFl3cU9V?=
 =?utf-8?B?QTJ4L2pVc0J5SHM1eVJhOHU4eERWcm9yTkVJQ3ltV210eGw2NU5OYUhIQnEw?=
 =?utf-8?B?ZTNjUEl0dWNGWk1vZW9RckZjM1NBd1YwVXEvTGh2Uy9iQTdxZGZHaTUyelVj?=
 =?utf-8?B?eFVYK2M1U2k1bDVvZTFSejVWMVFJYXVYMWpIdXBKU2c3cDE3NlZlTC95cjh1?=
 =?utf-8?B?djZScFdndWhvSW9VTHRLcFVHSGhRU3JsYUhuTGZ1VjNVNnRVMUM3ZVdmOXZI?=
 =?utf-8?B?em9IVUVZWFJ6ZUNtT3FoNi9RZlBiT2l0YzlkSFpYNFFkTVpZdUtxY1pSTUti?=
 =?utf-8?B?WWFZSXBCS0NvcGdDbEQraVBLS00zZUttclNZK1liNXFDZFBtZzNqbmFCTnNR?=
 =?utf-8?B?WGtPaUNoUDlzZ3IzV1lMZ204NWVCZWl6NHVVd0xsNFRnWGovN3AyNkwwZGM3?=
 =?utf-8?B?Y3MyNmYxMFhBR01KanVia3dJV3RySXFTUGw5cFdWZFVFcXpQSEw0bGV4aWRh?=
 =?utf-8?B?Tmt4eGh6a1hDampXT1VtaUlsK1dJd3RpYWZrM2VobEp2MkxOSEFqQW9Fc1dS?=
 =?utf-8?B?TnZWNzRkdlR3WnIrdWNLSHU4MmFJWHVXRmNjZmFNdDMzdVVsNVpBOTZhV2pX?=
 =?utf-8?B?U2dPQTFEblQzQ2VQdWRSelByZTdOeW9aekFIdGdlanl2TDBjeHZUYlFob2dr?=
 =?utf-8?B?MzBLakpKSk9PYWFZSXRrMTJPRVZ1MEMwaVpjZ0lRRzZYbDFGelNjOWdvNitE?=
 =?utf-8?B?SXYwVFU0cUpIbzBGczVlZmdTUnlFSVh3dklVdmlPR2dlSmc3SHpJWlBkVWJC?=
 =?utf-8?B?NmVTOUxoNWJHdWNwalZNalNqNlh5dnArSzJqampDM3pWZ0dQZzBiR3ZnUnRm?=
 =?utf-8?B?T1ZMaURsTVFqR0czc2tSamJXMVZNQjFCMW5Eekl1NUdmWUwwajJnamh0bEFY?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea847ca-d70c-4c3e-776f-08dd192244f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:55:13.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaP3FMTFvWY/8BH3g0xDws8F/L6+lStXc/vciVBcYbZaXnjO2CRwVPIakU7zEniheMJALmYU4OU16k6HuV2h2BMDTEmhQtezcWlDmoaChb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-OriginatorOrg: intel.com

From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Tue, 10 Dec 2024 12:44:04 +0100

> 
> 
> On 06.12.24 16:20, Alexandra Winter wrote:
>>
>>
>> On 04.12.24 15:32, Alexander Lobakin wrote:
>>>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>>>>  {
>>>>  	struct mlx5e_sq_stats *stats = sq->stats;
>>>>  
>>>> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
>>>> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
>>    +		skb_linearize(skb);
>>> 1. What's with the direct DMA? I believe it would benefit, too?
>>
>>
>> Removing the use_dma_iommu check is fine with us (s390). It is just a proposal to reduce the impact.
>> Any opinions from the NVidia people?
>>
> Agreed.
> 
>>
>>> 2. Why truesize, not something like
>>>
>>> 	if (skb->len <= some_sane_value_maybe_1k)
>>
>>
>> With (skb->truesize <= PAGE_SIZE) the whole "head" buffer fits into 1 page.
>> When we set the threshhold at a smaller value, skb->len makes more sense
>>
>>
>>>
>>> 3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
>>>    it's a good idea to rely on this.
>>>    Some test-based hardcode would be enough (i.e. threshold on which
>>>    DMA mapping starts performing better).
>>
>>
>> A threshhold of 4k is absolutely fine with us (s390). 
>> A threshhold of 1k would definitvely improve our situation and bring back the performance for some important scenarios.
>>
>>
>> NVidia people do you have any opinion on a good threshhold?
>>
> 1KB is still to large. As Tariq mentioned, the threshold should not
> exceed 128/256B. I am currently testing this with 256B on x86. So far no
> regressions but I need to play with it more.

On different setups, usually the copybreak of 192 or 256 bytes was the
most efficient as well.

> 
> Thanks,
> Dragos

Thanks,
Olek
