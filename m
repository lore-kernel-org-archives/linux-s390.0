Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95842186E3A
	for <linux-s390@vger.kernel.org>; Tue, 24 Sep 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220395; cv=fail; b=dFdRzLna7tKaRaRCWc1IZfLHxCfLgNrBDMIjIw1HzIOkNyXCnsBc63VL898ICuMGmDeYveGv68rAYzc6Uk2ndBDDFMtIsHySkAwCoKgZlQcku6zFL6O7FrDsidnKqJrZBYuE21+5y4Q1n1uSqIn2K9CYKLaLPxjoTP6CI/ENbpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220395; c=relaxed/simple;
	bh=r+DUDGHxF54+QMaLN1+jS/TybsuyItsyK2L9ciY9C1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CKY4hT420i98apa+cgAVxAzT6ZwOw7/oRe9zwctdyYxmm7Gm1BCFX59pk22unkAk38sYoaD539awg9WFK6CiRbOym5r1Is2fgMOlVQ/w+WyDWOCGP/HML/vsgsbzJnkvx37laEY5HD+CC4KbI6d6BE8u9I73ml2cr7Ysh5XhHM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZJUnTq8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZJUnTq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727220392; x=1758756392;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r+DUDGHxF54+QMaLN1+jS/TybsuyItsyK2L9ciY9C1Q=;
  b=iZJUnTq8kADyBE7C06w9+Ayhl0u3eBUIi/i5RZrBYjwg38hc7uSymyu/
   fNw4W6JcqaTQI1ffPojf825NzMr5p+KCsb8e2QErQnEyKVGWUzoN5EZRU
   7QkesqQwzLpPFajbl1OZrRPW1xg8NQgwxTzy1RCE7nB/o6v5JS1PzjIFn
   kWqRCXm46zYEZwFYZVLGPTADycWQ0MFXoggrF6+FdMQSewUC04nGOLZGA
   tDyUNp7B5fAwKhppI2wAVfXlSXhHi8k6Hm7Lj13auDibgdaSJToJ5uf/z
   NVDMLHjwZZ+Cdzklyk5KMe5gFML7h3f1zXJaE5glKZ6+7DnjNjKP4Yxhd
   Q==;
X-CSE-ConnectionGUID: rzbwDLeLQM2/55luAGMmOg==
X-CSE-MsgGUID: NJZFG1LTSniE/5GYWbMFqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25759337"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="25759337"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:26:30 -0700
X-CSE-ConnectionGUID: dQtOCuRFSJehDAuQoa44Qg==
X-CSE-MsgGUID: 2KthIuMhT+ifdbb5uniZww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71586115"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 16:26:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 16:26:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 16:26:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 16:26:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 16:26:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQCsQtJeG5/BwE4SmTG6SyUy4opNSQwOiPEC1IiWK/bzVfkxbcUcdhzC9w9f96bS0007mObM4iBG6dBzrrVHqE6cCmLCLcYM3wEiXrDTMY2AKZrq2cZnpZHC2dL6ykNpZwAv37F55lwCiku0CbJepBbGnHD2EJQw5njRydVGdQmWXwanwMI/EYIARWmKUY6tWc8ANklb8eEpWeDxp54BE9tROWyNPvp9uKJvTGL2XQP9hvYDuGHY5QFQ0IA14hT0z1ni/TmzTGa1t5phy9R8towpNdh2XdNR6kH86EmLQpJiPD0yrg6e4t+3Rw5qw6XNNMTctdY1BJaUc1uYp3oa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nRXdQMkRtYoVaVIujvdghS3nupY/bBtKqWDrfTTmw8=;
 b=hiu5fJrbR6UtXkYqKMqe0/XdRfREGCDVAStqB4a/ObCCkWmUq7qiMYWNC57s0ldcINGYYg0edNh4/Q5lbPqMHTfdEz8QbLMhKA+aNMbdsBUK3hausp6OHoreZXSkX1gwKff8GfwFUUdWtIvJDOLV1N8uoYQJrhwEbTnFt3liHLquuyRqbJPOZJRE8vLAyF8v88CWtkrxJbpbdbvIDgPEHctB2VMLztfQSgQ66JsbRiM85EzsIMDwIg2UVOXuv+8aRDgpu8JIHadYAeoz3c7kxRsgjn1OVFidMlGJvH4ScO+ifbZ3DYHX3pAa55KDuYjdvtqSK85Y4Nb3dh0I1Nt38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 23:26:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 23:26:23 +0000
Date: Tue, 24 Sep 2024 16:26:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>
CC: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Jan Kara
	<jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@lst.de>, Alistair Popple <apopple@nvidia.com>,
	<linux-s390@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] dcssblk: Mark DAX broken
Message-ID: <66f34a9caeb97_2a7f294fa@dwillia2-xfh.jf.intel.com.notmuch>
References: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad9589c-e8a2-407a-dc04-08dcdcf04d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0+2I/YRv/KEPU6hC7do4M1hWSnZ5DIsS+rpyd+QB6PT8kk0Ue7Sw0aiM/zGK?=
 =?us-ascii?Q?Tgjc1UJc7P5oZb99rfMZ+o2CBbRPcdtOGw9WHgUGhVetxtKzOxVw8PZ05nj3?=
 =?us-ascii?Q?hWYv6PHwrwxgfaUEnq3Zd5bWfxT+jqUIxXeAmcpEaVb3KAewvh0zNlOkLlr/?=
 =?us-ascii?Q?7ER9WN7x7rxcNukoGUffKu+n0tCz90DqWLx1SjWV1FQ1NbvxcPtd655i24MS?=
 =?us-ascii?Q?EM08ACuKZLDOkBwIeZ5o5BaUR3XFLIWwaEfF23tlQj3507o9If7vaBOL5uEr?=
 =?us-ascii?Q?6EKS6qQ2ptru452Y5aw6RFElB8gVo+kL4W+Nonb/+OtO9a67KXTssq5orqE3?=
 =?us-ascii?Q?ucO5MP+biXyyJV13VTlPXpcAZqZhVnyqtxB2E5yLBuAIuX4dxcfftSUd2FMv?=
 =?us-ascii?Q?QVsoUWEQF7lxVRB8CLRveVDF9dU3MILtpQqFuYK9heW9m/H+xXFVtu2sJ379?=
 =?us-ascii?Q?hAa9dcVZMWvC2n93cDBCFvvnm7FL32/eN9VKsXC4FBvaxtn8u/OG2gO0f5mL?=
 =?us-ascii?Q?Gg6Fer2+wm54zEiGEAj4ZV89U3yFwSUc260Cv/GFmfHuBjSoYckK5Z5yyrJV?=
 =?us-ascii?Q?Ov/zq/zlbhzQOxRvc98TUaHAXxexkpPb9sp22MO4RNisnjCdrPY01PiagBkZ?=
 =?us-ascii?Q?6TH3ORRdJMyf7JRmLos3yfnMoXDACX3uCAmMlzKret336DUkWdPjr0SPhaHg?=
 =?us-ascii?Q?pMSUNeWNXgWfa7JEZlHyQa0mvMw1hWiGLtc7m+diVAKOYM8ICBGAKtk0Ps0c?=
 =?us-ascii?Q?AYZ4uMYxo2clgN59XqsM+ctLLpTvGLpbgGO6+NH1gW85RpP+DWq+JEOKYQie?=
 =?us-ascii?Q?52UdUcOA4LEC/U41BtYAHJz9gFt/yP0sREMEPufR/VqogKwmNX5JX6P4kL16?=
 =?us-ascii?Q?9P+L2BT3w8hnucVuSdKhxtP4JE+D15BrYgT3zF3zZctP3KlL/STc7912r6r+?=
 =?us-ascii?Q?FTyFdrooqn14oeIjxNiDSll3hwQv6zU7r++2nvpPC0pdqtYkfwjIWl9eoNuf?=
 =?us-ascii?Q?shBLH1vWPw8unyI3BFeeEyHtgYRrPj+bmQxN9TKNCdfdVxTotQmTpm3KM00s?=
 =?us-ascii?Q?P1pnOo403VK+FzGlH2/3vGLUw3KQge4AHkmez89XMnMwCSfeFRLO2JdS1N69?=
 =?us-ascii?Q?vxVdEII8Gxx3GP8mKbpGJmQldJqLmsxB5rRHnb4RyZrP9Z0z+RruvsAuvixf?=
 =?us-ascii?Q?D9tY2RY8Fr0OT9XOnKvRi7VDRM1NXcue++ksxwd55TlNwScFD6Ge61AMfkwl?=
 =?us-ascii?Q?UtuYDV+Bx8HvICrFlGYy8ukE0RtjoiEroOGdbrO8KY/gjqro6bLCsQykcbBN?=
 =?us-ascii?Q?dSE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPCpulCGbIAzYGXwRlVLheCQbVV+V0WT8ZYlAfsnSAI0wgFmuDPvvPkJp98C?=
 =?us-ascii?Q?iYL0k9FE9EZpFLTFk++ExCC+9Wmi1LL3YmyaeKMdghLqHB54mk/97vwrREUs?=
 =?us-ascii?Q?PYuD2QX0dWSXRS0idMT8w5n+tGVnpVz8mSW3Znfd+BRhHXbhtoUMTMpAPxXM?=
 =?us-ascii?Q?FnUZtj1rQpmSTvdLDq130yYLz0BI7cHNrU09hMers9g4J1NolBnhjmEmy2+8?=
 =?us-ascii?Q?obw4EXUtmGtzgE3Owv2r5Vz1TuYut2I/bpg0+tqyRck5GpZBURBbKc2Jd7Qv?=
 =?us-ascii?Q?zqE9L04BiaJwgUuxudiPQYlIN/1of5JOtBGLNJmOyvUixlX3ncGuoLDyL4Y5?=
 =?us-ascii?Q?Ma1pmDVpJapHqTNyacWQHrAo9cwgnzmO5T+k1LX0IoXOXnOEbKn3p0dzDZHq?=
 =?us-ascii?Q?P1R/jIfagR2krUh51lRPAF2d7wPkHHPz9NtfZbQ5WcAODgnTKyKQMJuHit1I?=
 =?us-ascii?Q?/0NB6JqY/VXUfeB6EAg7SL2KgCSFo4KwYmLqZKtwRt71GAgSreStgu6nVztt?=
 =?us-ascii?Q?CfRNgbv1EEmGVIod1RRA8LPB0JHXHGUtA1BdDwOcIn44EKHQa+Cjp77vYWI3?=
 =?us-ascii?Q?fktfwf6bCeYcUZNB+uaCFn9/7CBdk+hxmdf8e8Jnyd1ZoeMMH5KjkXRuipAJ?=
 =?us-ascii?Q?Fcpcmdhq2XyFWnEVz749Dn5t1HrdN4NcZS/hlX2Gq/4IZ8GQErPOyINM5L2G?=
 =?us-ascii?Q?8jKC4VOz9fFk1jygBZlu8Uy6VKfTlcJda+76w+SZnTu0WgnVK5le39QhdWOp?=
 =?us-ascii?Q?aN3aWcctcf8IcqyV2Zoh1rrhLkYB+D6MW52hsSsR+BWPQ5qgaXe9P1lF1xuU?=
 =?us-ascii?Q?uldet9mAHdukJjNYBiS+1cpr5afbDtBNQX7148wrwwGIH8n6VJv4XnWG4kDY?=
 =?us-ascii?Q?3PNNWjdeU1ChmUN+czfXmVmSPNF9H4Mpyye4oT5u0yiVDJqXqXmH2pS1+MB/?=
 =?us-ascii?Q?7N/CXEGKHnOsTNxI2RP6qKHgTbmGgr+PWylDlo6WZpLnz3nPzY7XsY9RGlnb?=
 =?us-ascii?Q?neSX2KdfLkKfcj390i2HSypqhBJGlga7flNLi2lQ1KhO0gXr0NCAVVWJsS8B?=
 =?us-ascii?Q?oiPaa/mGjeTqsMxPuhKNKGsv9x386yfhkfjfRCVUp+Gz2MB14vq/SMGob+FC?=
 =?us-ascii?Q?+/1YpygzQ9LMjqf9AE9Cj919Eisn2N4w6IsB+H2si6DD0ZTrB/coytrP/32t?=
 =?us-ascii?Q?yk40lEAXGNdKzl/eBciog+2VHXmQTf4oyPd5qJUGU2t9MjYDydcewmP4qHPe?=
 =?us-ascii?Q?uyaRvf8B0TfMUW/QjSC6kHj99/64yXnI+NN8/4htNnYBmjqiCsnnrzBTOR6N?=
 =?us-ascii?Q?gAq8U0O6atSHJ8PxV/rIhyBaxlpqhsvUrd6GbeGfStZ4P6Qy8vo/XtgT5h4n?=
 =?us-ascii?Q?u1BvTyYPv+wA7D7wi34+McuqxJuf2IVEVa4iNX9LocA9UAiP52zxb/ag9Qxu?=
 =?us-ascii?Q?S8HfWLD+RLSQKxPSyZvTd7leE9+SteRLRqehFUoa3uAJ2OoRDTyfGBfbIAUU?=
 =?us-ascii?Q?PTpquJs5l6hWPmjN7LrLCHdOy4QatIgauCjeJWfNsr7+4zcMS0/Rg9n+pkBV?=
 =?us-ascii?Q?lPDPCL7R/uWfyvb6UCk2bEKiygADyPxAbfTfF2ACWGutw/2zaYs5wcfRky6L?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad9589c-e8a2-407a-dc04-08dcdcf04d97
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 23:26:23.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W33rAsA5GpeA+bzi697Uqm787UwbaMtgHiACplta9jBC8xUlft3051odxpvF5jDsOPGz4lPr5MA2dfXIzoa9iBcn616hwLj7KJK+Uy21GpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

Dan Williams wrote:
> The dcssblk driver has long needed special case supoprt to enable
> limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
> works around the incomplete support for ZONE_DEVICE on s390 by forgoing
> the ability of dax-mapped pages to support GUP.
> 
> Now, pending cleanups to fsdax that fix its reference counting [1] depend on
> the ability of all dax drivers to supply ZONE_DEVICE pages.
> 
> To allow that work to move forward, dax support needs to be paused for
> dcssblk until ZONE_DEVICE support arrives. That work has been known for
> a few years [2], and the removal of "pte_devmap" requirements [3] makes the
> conversion easier.
> 
> For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
> (dcssblk was the only user).
> 
> Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
> Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
> Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/s390/block/Kconfig   |   12 ++++++++++--
>  drivers/s390/block/dcssblk.c |   26 +++++++++++++++++---------
>  fs/Kconfig                   |    9 +--------
>  fs/dax.c                     |   12 ------------
>  include/linux/pfn_t.h        |   15 ---------------
>  mm/memory.c                  |    2 --
>  mm/memremap.c                |    4 ----
>  7 files changed, 28 insertions(+), 52 deletions(-)

As additional motivation, with this addressed, pfn_t can also be removed
for "moar red-diff!":  44 files changed, 141 insertions(+), 301 deletions(-)

Patch below is on top of Alistair's series. It will need to be rebased
on top of the final version of that, but here it is for demonstration
purposes.

-- >8 --
Subject: mm: Remove pfn_t

From: Dan Williams <dan.j.williams@intel.com>

The pfn_t type was created to convey mapping constraints from
->direct_acces() methods to core mm helpers like vmf_insert_mixed(). Now
that all ->direct_access() helpers return ZONE_DEVICE pages, and
ZONE_DEVICE pages no longer require pte_devmap, there is no longer a
need for pfn_t.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/pat/memtype.c                |    5 +-
 drivers/dax/device.c                     |   19 +++---
 drivers/dax/hmem/hmem.c                  |    1 
 drivers/dax/kmem.c                       |    1 
 drivers/dax/pmem.c                       |    1 
 drivers/dax/pmem/pmem.c                  |    1 
 drivers/dax/super.c                      |    3 -
 drivers/gpu/drm/exynos/exynos_drm_gem.c  |    1 
 drivers/gpu/drm/gma500/fbdev.c           |    3 -
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |    1 
 drivers/gpu/drm/msm/msm_gem.c            |    1 
 drivers/gpu/drm/omapdrm/omap_gem.c       |    7 +-
 drivers/gpu/drm/v3d/v3d_bo.c             |    1 
 drivers/md/dm-linear.c                   |    4 +
 drivers/md/dm-log-writes.c               |    5 +-
 drivers/md/dm-stripe.c                   |    4 +
 drivers/md/dm-target.c                   |    4 +
 drivers/md/dm-writecache.c               |   16 +----
 drivers/md/dm.c                          |    4 +
 drivers/nvdimm/pmem.c                    |   15 ++---
 drivers/nvdimm/pmem.h                    |    6 +-
 drivers/s390/block/dcssblk.c             |   21 +++----
 fs/cramfs/inode.c                        |    4 +
 fs/dax.c                                 |   53 +++++++++--------
 fs/ext4/file.c                           |    2 -
 fs/fuse/dax.c                            |    3 -
 fs/fuse/virtio_fs.c                      |    5 +-
 fs/xfs/xfs_file.c                        |    2 -
 include/linux/dax.h                      |   12 ++--
 include/linux/device-mapper.h            |    7 +-
 include/linux/huge_mm.h                  |    8 +--
 include/linux/mm.h                       |    7 +-
 include/linux/pfn.h                      |   13 ----
 include/linux/pfn_t.h                    |   96 ------------------------------
 include/linux/pgtable.h                  |    4 +
 include/trace/events/fs_dax.h            |   14 ++--
 mm/debug_vm_pgtable.c                    |    1 
 mm/huge_memory.c                         |   27 ++++----
 mm/memory.c                              |   38 +++++-------
 mm/memremap.c                            |    1 
 mm/migrate.c                             |    1 
 tools/testing/nvdimm/pmem-dax.c          |    8 +--
 tools/testing/nvdimm/test/iomap.c        |   11 ---
 tools/testing/nvdimm/test/nfit_test.h    |    1 
 44 files changed, 141 insertions(+), 301 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index eb84593cf95c..da57ccb2da34 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -36,7 +36,6 @@
 #include <linux/debugfs.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
@@ -1074,7 +1073,7 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 	return 0;
 }
 
-void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
+void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, unsigned long pfn)
 {
 	enum page_cache_mode pcm;
 
@@ -1082,7 +1081,7 @@ void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
 		return;
 
 	/* Set prot based on lookup */
-	pcm = lookup_memtype(pfn_t_to_phys(pfn));
+	pcm = lookup_memtype(PFN_PHYS(pfn));
 	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
 			 cachemode2protval(pcm));
 }
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 4d3ddd128790..aae90a5bcd30 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -4,7 +4,6 @@
 #include <linux/pagemap.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
@@ -73,8 +72,8 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 	return -1;
 }
 
-static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
-			      unsigned long fault_size)
+static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
+			    unsigned long fault_size)
 {
 	unsigned long i, nr_pages = fault_size / PAGE_SIZE;
 	struct file *filp = vmf->vma->vm_file;
@@ -89,7 +88,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
 			ALIGN(vmf->address, fault_size));
 
 	for (i = 0; i < nr_pages; i++) {
-		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
+		struct page *page = pfn_to_page(pfn + i);
 
 		page = compound_head(page);
 		if (page->mapping)
@@ -105,7 +104,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 {
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -126,7 +125,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
@@ -140,7 +139,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PMD_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -169,7 +168,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
@@ -184,7 +183,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PUD_SIZE;
 
 
@@ -214,7 +213,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f18491..c18451a37e4f 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -2,7 +2,6 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/dax.h>
 #include "../bus.h"
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index e97d47f42ee2..87b5321675ff 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -5,7 +5,6 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index c8ebf4e281f2..bee93066a849 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include "../nvdimm/pfn.h"
 #include "../nvdimm/nd.h"
 #include "bus.h"
diff --git a/drivers/dax/pmem/pmem.c b/drivers/dax/pmem/pmem.c
index dfe91a2990fe..ce3394617d15 100644
--- a/drivers/dax/pmem/pmem.c
+++ b/drivers/dax/pmem/pmem.c
@@ -3,7 +3,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/nd.h>
 #include "../bus.h"
 
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 57a94a6c00e5..3706d803acbf 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -7,7 +7,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/magic.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
@@ -148,7 +147,7 @@ enum dax_device_flags {
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn)
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn)
 {
 	long avail;
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 638ca96830e9..ab8d6cea09f5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -7,7 +7,6 @@
 
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/shmem_fs.h>
 #include <linux/module.h>
 
diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 98b44974d42d..997c9038db38 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -6,7 +6,6 @@
  **************************************************************************/
 
 #include <linux/fb.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
@@ -33,7 +32,7 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, PFN_DEV));
+		err = vmf_insert_mixed(vma, address, pfn);
 		if (unlikely(err & VM_FAULT_ERROR))
 			break;
 		address += PAGE_SIZE;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index cac6d4184506..4faab805909d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -6,7 +6,6 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/mman.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 
 #include <drm/drm_cache.h>
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index ebc9ba66efb8..1c275008b223 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -9,7 +9,6 @@
 #include <linux/spinlock.h>
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_prime.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index fdae677558f3..5523196f5b28 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -8,7 +8,6 @@
 #include <linux/seq_file.h>
 #include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include <drm/drm_prime.h>
@@ -371,8 +370,7 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vmf_insert_mixed(vma, vmf->address,
-			__pfn_to_pfn_t(pfn, PFN_DEV));
+	return vmf_insert_mixed(vma, vmf->address, pfn);
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
@@ -467,8 +465,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 			pfn, pfn << PAGE_SHIFT);
 
 	for (i = n; i > 0; i--) {
-		ret = vmf_insert_mixed(vma,
-			vaddr, __pfn_to_pfn_t(pfn, PFN_DEV));
+		ret = vmf_insert_mixed(vma, vaddr, pfn);
 		if (ret & VM_FAULT_ERROR)
 			break;
 		pfn += priv->usergart[fmt].stride_pfn;
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a165cbcdd27b..091bc758b23a 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include "v3d_drv.h"
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 49fb0f684193..211528d1eebf 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -167,8 +167,8 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+				     long nr_pages, enum dax_access_mode mode,
+				     void **kaddr, unsigned long *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 8d7df8303d0a..63037f0cd277 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -890,8 +890,9 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 }
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+					 long nr_pages,
+					 enum dax_access_mode mode,
+					 void **kaddr, unsigned long *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 4112071de0be..b13c43d716f1 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -315,8 +315,8 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+				     long nr_pages, enum dax_access_mode mode,
+				     void **kaddr, unsigned long *pfn)
 {
 	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 652627aea11b..6dfb6d680f2c 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -254,8 +254,8 @@ static void io_err_io_hints(struct dm_target *ti, struct queue_limits *limits)
 }
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+				     long nr_pages, enum dax_access_mode mode,
+				     void **kaddr, unsigned long *pfn)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 7ce8847b3404..2c841e30ae92 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -13,7 +13,6 @@
 #include <linux/dm-io.h>
 #include <linux/dm-kcopyd.h>
 #include <linux/dax.h>
-#include <linux/pfn_t.h>
 #include <linux/libnvdimm.h>
 #include <linux/delay.h>
 #include "dm-io-tracker.h"
@@ -256,7 +255,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 	int r;
 	loff_t s;
 	long p, da;
-	pfn_t pfn;
+	unsigned long pfn;
 	int id;
 	struct page **pages;
 	sector_t offset;
@@ -290,11 +289,6 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		r = da;
 		goto err2;
 	}
-	if (!pfn_t_has_page(pfn)) {
-		wc->memory_map = NULL;
-		r = -EOPNOTSUPP;
-		goto err2;
-	}
 	if (da != p) {
 		long i;
 
@@ -314,13 +308,9 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 				r = daa ? daa : -EINVAL;
 				goto err3;
 			}
-			if (!pfn_t_has_page(pfn)) {
-				r = -EOPNOTSUPP;
-				goto err3;
-			}
 			while (daa-- && i < p) {
-				pages[i++] = pfn_t_to_page(pfn);
-				pfn.val++;
+				pages[i++] = pfn_to_page(pfn);
+				pfn++;
 				if (!(i & 15))
 					cond_resched();
 			}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 87bb90303435..d24324c49433 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1231,8 +1231,8 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 }
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+				 long nr_pages, enum dax_access_mode mode,
+				 void **kaddr, unsigned long *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 451cd0fa0c94..d3b3febc8124 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -20,7 +20,6 @@
 #include <linux/kstrtox.h>
 #include <linux/vmalloc.h>
 #include <linux/blk-mq.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
@@ -242,7 +241,7 @@ static void pmem_submit_bio(struct bio *bio)
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
@@ -254,7 +253,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	if (bb->count &&
 	    badblocks_check(bb, sector, num, &first_bad, &num_bad)) {
@@ -301,9 +300,9 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 				   PAGE_SIZE));
 }
 
-static long pmem_dax_direct_access(struct dax_device *dax_dev,
-		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
-		void **kaddr, pfn_t *pfn)
+static long pmem_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+				   long nr_pages, enum dax_access_mode mode,
+				   void **kaddr, unsigned long *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
@@ -432,7 +431,8 @@ static void pmem_release_disk(void *__pmem)
 }
 
 static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
-		unsigned long pfn, unsigned long nr_pages, int mf_flags)
+				       unsigned long pfn,
+				       unsigned long nr_pages, int mf_flags)
 {
 	struct pmem_device *pmem =
 			container_of(pgmap, struct pmem_device, pgmap);
@@ -513,7 +513,6 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 392b0b38acb9..99ce3ac51fdd 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -5,7 +5,6 @@
 #include <linux/badblocks.h>
 #include <linux/memremap.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/fs.h>
 
 enum dax_access_mode;
@@ -16,7 +15,6 @@ struct pmem_device {
 	phys_addr_t		phys_addr;
 	/* when non-zero this device is hosting a 'pfn' instance */
 	phys_addr_t		data_offset;
-	u64			pfn_flags;
 	void			*virt_addr;
 	/* immutable base size of the namespace */
 	size_t			size;
@@ -30,8 +28,8 @@ struct pmem_device {
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+			  long nr_pages, enum dax_access_mode mode,
+			  void **kaddr, unsigned long *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index d1bc79cf56bd..9b537020fe25 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -17,7 +17,6 @@
 #include <linux/blkdev.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
-#include <linux/pfn_t.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/io.h>
@@ -32,8 +31,8 @@ static int dcssblk_open(struct gendisk *disk, blk_mode_t mode);
 static void dcssblk_release(struct gendisk *disk);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+				      long nr_pages, enum dax_access_mode mode,
+				      void **kaddr, unsigned long *pfn);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -919,9 +918,9 @@ dcssblk_submit_bio(struct bio *bio)
 	bio_io_error(bio);
 }
 
-static long
-__dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+static long __dcssblk_direct_access(struct dcssblk_dev_info *dev_info,
+				    pgoff_t pgoff, long nr_pages, void **kaddr,
+				    unsigned long *pfn)
 {
 	resource_size_t offset = pgoff * PAGE_SIZE;
 	unsigned long dev_sz;
@@ -930,16 +929,14 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				      PFN_DEV);
+		*pfn = PFN_DOWN(dev_info->start + offset);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
 
-static long
-dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+				      long nr_pages, enum dax_access_mode mode,
+				      void **kaddr, unsigned long *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b84d1747a020..ba7f7ca2aebc 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/ramfs.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -412,7 +411,8 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		for (i = 0; i < pages && !ret; i++) {
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
-			pfn_t pfn = phys_to_pfn_t(address + off, PFN_DEV);
+			unsigned long pfn = PHYS_PFN(address + off);
+
 			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
diff --git a/fs/dax.c b/fs/dax.c
index 72d6d4586330..fcbe62bde685 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -20,7 +20,6 @@
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
 #include <linux/vmstat.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
@@ -76,9 +75,9 @@ static struct folio *dax_to_folio(void *entry)
 	return page_folio(pfn_to_page(dax_to_pfn(entry)));
 }
 
-static void *dax_make_entry(pfn_t pfn, unsigned long flags)
+static void *dax_make_entry(unsigned long pfn, unsigned long flags)
 {
-	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
+	return xa_mk_value(flags | (pfn << DAX_SHIFT));
 }
 
 static bool dax_is_locked(void *entry)
@@ -612,7 +611,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 		if (order > 0)
 			flags |= DAX_PMD;
-		entry = dax_make_entry(pfn_to_pfn_t(0), flags);
+		entry = dax_make_entry(0, flags);
 		dax_lock_entry(xas, entry);
 		if (xas_error(xas))
 			goto out_unlock;
@@ -837,7 +836,7 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
  * appropriate.
  */
 static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap_iter *iter, void *entry, pfn_t pfn,
+		const struct iomap_iter *iter, void *entry, unsigned long pfn,
 		unsigned long flags)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1036,7 +1035,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
-		size_t size, void **kaddr, pfn_t *pfnp)
+				   size_t size, void **kaddr,
+				   unsigned long *pfnp)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	int id, rc = 0;
@@ -1054,7 +1054,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
-	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
+	if (*pfnp & (PHYS_PFN(size)-1))
 		goto out;
 
 	rc = 0;
@@ -1158,8 +1158,8 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 {
 	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
-	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
-	struct page *page = pfn_t_to_page(pfn);
+	unsigned long pfn = my_zero_pfn(vaddr);
+	struct page *page = pfn_to_page(pfn);
 	vm_fault_t ret;
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
@@ -1183,7 +1183,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	struct folio *zero_folio;
 	spinlock_t *ptl;
 	pmd_t pmd_entry;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1195,7 +1195,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	if (unlikely(!zero_folio))
 		goto fallback;
 
-	pfn = page_to_pfn_t(&zero_folio->page);
+	pfn = page_to_pfn(&zero_folio->page);
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
 				  DAX_PMD | DAX_ZERO_PAGE);
 
@@ -1564,7 +1564,7 @@ static vm_fault_t dax_fault_return(int error)
  * insertion for now and return the pfn so that caller can insert it after the
  * fsync is done.
  */
-static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
+static vm_fault_t dax_fault_synchronous_pfnp(unsigned long *pfnp, unsigned long pfn)
 {
 	if (WARN_ON_ONCE(!pfnp))
 		return VM_FAULT_SIGBUS;
@@ -1612,8 +1612,9 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
  * @pmd:	distinguish whether it is a pmd fault
  */
 static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
-		const struct iomap_iter *iter, pfn_t *pfnp,
-		struct xa_state *xas, void **entry, bool pmd)
+				 const struct iomap_iter *iter,
+				 unsigned long *pfnp, struct xa_state *xas,
+				 void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -1622,7 +1623,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	int ret, err = 0;
-	pfn_t pfn;
+	unsigned long pfn;
 	void *kaddr;
 	struct page *page;
 
@@ -1657,7 +1658,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	page = pfn_t_to_page(pfn);
+	page = pfn_to_page(pfn);
 	page_ref_inc(page);
 
 	if (pmd)
@@ -1674,8 +1675,9 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	return ret;
 }
 
-static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
-			       int *iomap_errp, const struct iomap_ops *ops)
+static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, unsigned long *pfnp,
+				      int *iomap_errp,
+				      const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
@@ -1784,7 +1786,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 	return false;
 }
 
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1863,8 +1865,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	return ret;
 }
 #else
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
-			       const struct iomap_ops *ops)
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
+				      const struct iomap_ops *ops)
 {
 	return VM_FAULT_FALLBACK;
 }
@@ -1884,7 +1886,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * successfully.
  */
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
+			   unsigned long *pfnp, int *iomap_errp,
+			   const struct iomap_ops *ops)
 {
 	if (order == 0)
 		return dax_iomap_pte_fault(vmf, pfnp, iomap_errp, ops);
@@ -1905,7 +1908,7 @@ EXPORT_SYMBOL_GPL(dax_iomap_fault);
  * for an mmaped DAX file.  It also marks the page cache entry as dirty.
  */
 static vm_fault_t
-dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
+dax_insert_pfn_mkwrite(struct vm_fault *vmf, unsigned long pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
@@ -1927,7 +1930,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
-	page = pfn_t_to_page(pfn);
+	page = pfn_to_page(pfn);
 	page_ref_inc(page);
 	if (order == 0)
 		ret = dax_insert_pfn(vmf, pfn, true);
@@ -1954,7 +1957,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
  * table entry.
  */
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
-		pfn_t pfn)
+				 unsigned long pfn)
 {
 	int err;
 	loff_t start = ((loff_t)vmf->pgoff) << PAGE_SHIFT;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..13e939bcc7ac 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -722,7 +722,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index da505956208f..0b6b440520da 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -10,7 +10,6 @@
 #include <linux/dax.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/iomap.h>
 #include <linux/interval_tree.h>
 
@@ -788,7 +787,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,
 	vm_fault_t ret;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
-	pfn_t pfn;
+	unsigned long pfn;
 	int error = 0;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_conn_dax *fcd = fc->dax;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f79a94d148da..e49e2ae33206 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -9,7 +9,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/group_cpus.h>
-#include <linux/pfn_t.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
@@ -866,7 +865,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 				    long nr_pages, enum dax_access_mode mode,
-				    void **kaddr, pfn_t *pfn)
+				    void **kaddr, unsigned long *pfn)
 {
 	struct virtio_fs *fs = dax_get_private(dax_dev);
 	phys_addr_t offset = PFN_PHYS(pgoff);
@@ -875,7 +874,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
+		*pfn = PHYS_PFN(fs->window_phys_addr + offset);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..47edb2785ad2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1243,7 +1243,7 @@ xfs_dax_fault_locked(
 	bool			write_fault)
 {
 	vm_fault_t		ret;
-	pfn_t			pfn;
+	unsigned long		pfn;
 
 	if (!IS_ENABLED(CONFIG_FS_DAX)) {
 		ASSERT(0);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0f6f355ec3b5..153dd2398178 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -26,7 +26,7 @@ struct dax_operations {
 	 * number of pages available for DAX at that pfn.
 	 */
 	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			enum dax_access_mode, void **, pfn_t *);
+			      enum dax_access_mode, void **, unsigned long *);
 	/*
 	 * Validate whether this device is usable as an fsdax backing
 	 * device.
@@ -241,7 +241,8 @@ static inline void dax_read_unlock(int id)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn);
+		       enum dax_access_mode mode, void **kaddr,
+		       unsigned long *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
@@ -255,9 +256,10 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
-vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
-		unsigned int order, pfn_t pfn);
+			   unsigned long *pfnp, int *errp,
+			   const struct iomap_ops *ops);
+vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
+				 unsigned long pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 53ca3a913d06..05fadca5b588 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -147,9 +147,10 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  *  < 0 : error
  * >= 0 : the number of bytes accessible at the address
  */
-typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode node, void **kaddr,
-		pfn_t *pfn);
+typedef long (*dm_dax_direct_access_fn)(struct dm_target *ti, pgoff_t pgoff,
+					long nr_pages,
+					enum dax_access_mode node, void **kaddr,
+					unsigned long *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 79a24ac31080..a047379d94ad 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -38,10 +38,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
 
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn, bool write);
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn, bool write);
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn, bool write);
+vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d9517e109ac3..41a419c549ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3437,14 +3437,15 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
-vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write);
+vm_fault_t dax_insert_pfn(struct vm_fault *vmf, unsigned long pfn, bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn);
-int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
+			    unsigned long pfn);
+int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start,
+		    unsigned long len);
 
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
 				unsigned long addr, struct page *page)
diff --git a/include/linux/pfn.h b/include/linux/pfn.h
index 14bc053c53d8..482cf9a07fda 100644
--- a/include/linux/pfn.h
+++ b/include/linux/pfn.h
@@ -2,19 +2,6 @@
 #ifndef _LINUX_PFN_H_
 #define _LINUX_PFN_H_
 
-#ifndef __ASSEMBLY__
-#include <linux/types.h>
-
-/*
- * pfn_t: encapsulates a page-frame number that is optionally backed
- * by memmap (struct page).  Whether a pfn_t has a 'struct page'
- * backing is indicated by flags in the high bits of the value.
- */
-typedef struct {
-	u64 val;
-} pfn_t;
-#endif
-
 #define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
deleted file mode 100644
index 76e519b20553..000000000000
--- a/include/linux/pfn_t.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PFN_T_H_
-#define _LINUX_PFN_T_H_
-#include <linux/mm.h>
-
-/*
- * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- * PFN_SG_CHAIN - pfn is a pointer to the next scatterlist entry
- * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
- * PFN_DEV - pfn is not covered by system memmap by default
- * PFN_MAP - pfn has a dynamic page mapping established by a device driver
- */
-#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-#define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
-#define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
-#define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
-
-#define PFN_FLAGS_TRACE \
-	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
-	{ PFN_SG_LAST,	"SG_LAST" }, \
-	{ PFN_DEV,	"DEV" }, \
-	{ PFN_MAP,	"MAP" }
-
-static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
-{
-	pfn_t pfn_t = { .val = pfn | (flags & PFN_FLAGS_MASK), };
-
-	return pfn_t;
-}
-
-/* a default pfn to pfn_t conversion assumes that @pfn is pfn_valid() */
-static inline pfn_t pfn_to_pfn_t(unsigned long pfn)
-{
-	return __pfn_to_pfn_t(pfn, 0);
-}
-
-static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
-{
-	return __pfn_to_pfn_t(addr >> PAGE_SHIFT, flags);
-}
-
-static inline bool pfn_t_has_page(pfn_t pfn)
-{
-	return (pfn.val & PFN_MAP) == PFN_MAP || (pfn.val & PFN_DEV) == 0;
-}
-
-static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
-{
-	return pfn.val & ~PFN_FLAGS_MASK;
-}
-
-static inline struct page *pfn_t_to_page(pfn_t pfn)
-{
-	if (pfn_t_has_page(pfn))
-		return pfn_to_page(pfn_t_to_pfn(pfn));
-	return NULL;
-}
-
-static inline phys_addr_t pfn_t_to_phys(pfn_t pfn)
-{
-	return PFN_PHYS(pfn_t_to_pfn(pfn));
-}
-
-static inline pfn_t page_to_pfn_t(struct page *page)
-{
-	return pfn_to_pfn_t(page_to_pfn(page));
-}
-
-static inline int pfn_t_valid(pfn_t pfn)
-{
-	return pfn_valid(pfn_t_to_pfn(pfn));
-}
-
-#ifdef CONFIG_MMU
-static inline pte_t pfn_t_pte(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pte(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline pmd_t pfn_t_pmd(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pmd(pfn_t_to_pfn(pfn), pgprot);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pud(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-#endif
-
-#endif /* _LINUX_PFN_T_H_ */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f3a95e38872c..d51e87e1adae 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1513,7 +1513,7 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
  * by vmf_insert_pfn().
  */
 static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-				    pfn_t pfn)
+				    unsigned long pfn)
 {
 }
 
@@ -1549,7 +1549,7 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long pfn, unsigned long addr,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-			     pfn_t pfn);
+			     unsigned long pfn);
 extern int track_pfn_copy(struct vm_area_struct *vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 86fe6aecff1e..10f706e37040 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -104,14 +104,14 @@ DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole_fallback);
 
 DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
-		long length, pfn_t pfn, void *radix_entry),
+		long length, unsigned long pfn, void *radix_entry),
 	TP_ARGS(inode, vmf, length, pfn, radix_entry),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
 		__field(unsigned long, vm_flags)
 		__field(unsigned long, address)
 		__field(long, length)
-		__field(u64, pfn_val)
+		__field(unsigned long, pfn)
 		__field(void *, radix_entry)
 		__field(dev_t, dev)
 		__field(int, write)
@@ -123,11 +123,11 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->address = vmf->address;
 		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
 		__entry->length = length;
-		__entry->pfn_val = pfn.val;
+		__entry->pfn = pfn;
 		__entry->radix_entry = radix_entry;
 	),
 	TP_printk("dev %d:%d ino %#lx %s %s address %#lx length %#lx "
-			"pfn %#llx %s radix_entry %#lx",
+			"pfn %#lx radix_entry %#lx",
 		MAJOR(__entry->dev),
 		MINOR(__entry->dev),
 		__entry->ino,
@@ -135,9 +135,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->write ? "write" : "read",
 		__entry->address,
 		__entry->length,
-		__entry->pfn_val & ~PFN_FLAGS_MASK,
-		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
-			PFN_FLAGS_TRACE),
+		__entry->pfn,
 		(unsigned long)__entry->radix_entry
 	)
 )
@@ -145,7 +143,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 #define DEFINE_PMD_INSERT_MAPPING_EVENT(name) \
 DEFINE_EVENT(dax_pmd_insert_mapping_class, name, \
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
-		long length, pfn_t pfn, void *radix_entry), \
+		long length, unsigned long pfn, void *radix_entry), \
 	TP_ARGS(inode, vmf, length, pfn, radix_entry))
 
 DEFINE_PMD_INSERT_MAPPING_EVENT(dax_pmd_insert_mapping);
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1262148d97b7..ec8e8d746658 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -20,7 +20,6 @@
 #include <linux/mman.h>
 #include <linux/mm_types.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/printk.h>
 #include <linux/pgtable.h>
 #include <linux/random.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7c39950bfdae..ea65c2db2bb1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -23,7 +23,6 @@
 #include <linux/mm_types.h>
 #include <linux/khugepaged.h>
 #include <linux/freezer.h>
-#include <linux/pfn_t.h>
 #include <linux/mman.h>
 #include <linux/memremap.h>
 #include <linux/pagemap.h>
@@ -1232,15 +1231,15 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 }
 
 static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
-		pgtable_t pgtable)
+			   pmd_t *pmd, unsigned long pfn, pgprot_t prot,
+			   bool write, pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t entry;
 
 	if (!pmd_none(*pmd)) {
 		if (write) {
-			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
 				return;
 			}
@@ -1253,7 +1252,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		return;
 	}
 
-	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
+	entry = pmd_mkhuge(pfn_pmd(pfn, prot));
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1279,7 +1278,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn, bool write)
 {
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1316,7 +1315,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
-vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn, bool write)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PMD_MASK;
@@ -1339,7 +1338,7 @@ vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 
 	ptl = pmd_lock(mm, vmf->pmd);
 	if (pmd_none(*vmf->pmd)) {
-		page = pfn_t_to_page(pfn);
+		page = pfn_to_page(pfn);
 		folio = page_folio(page);
 		folio_get(folio);
 		folio_add_file_rmap_pmd(folio, page, vma);
@@ -1364,7 +1363,7 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 }
 
 static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, bool write)
+			   pud_t *pud, unsigned long pfn, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgprot_t prot = vma->vm_page_prot;
@@ -1372,7 +1371,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pud_none(*pud)) {
 		if (write) {
-			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
+			if (pud_pfn(*pud) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
 				return;
 			}
@@ -1384,7 +1383,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 		return;
 	}
 
-	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
+	entry = pud_mkhuge(pfn_pud(pfn, prot));
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -1403,7 +1402,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn, bool write)
 {
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1440,7 +1439,7 @@ EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn, bool write)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PUD_MASK;
@@ -1458,7 +1457,7 @@ vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
 	ptl = pud_lock(mm, pud);
 	if (pud_none(*vmf->pud)) {
-		page = pfn_t_to_page(pfn);
+		page = pfn_to_page(pfn);
 		folio = page_folio(page);
 		folio_get(folio);
 		folio_add_file_rmap_pud(folio, page, vma);
diff --git a/mm/memory.c b/mm/memory.c
index 721aac02a636..ed75f561d445 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -59,7 +59,6 @@
 #include <linux/export.h>
 #include <linux/delayacct.h>
 #include <linux/init.h>
-#include <linux/pfn_t.h>
 #include <linux/writeback.h>
 #include <linux/memcontrol.h>
 #include <linux/mmu_notifier.h>
@@ -2327,7 +2326,7 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 EXPORT_SYMBOL(vm_map_pages_zero);
 
 static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			     pfn_t pfn, pgprot_t prot)
+			     unsigned long pfn, pgprot_t prot)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
@@ -2341,7 +2340,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unlock;
 
 	/* Ok, finally just insert the thing.. */
-	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_pte(pfn, prot));
 
 	set_pte_at(mm, addr, pte, entry);
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
@@ -2385,7 +2384,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
  * Return: vm_fault_t value.
  */
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot)
+			       unsigned long pfn, pgprot_t pgprot)
 {
 	/*
 	 * Technically, architectures with pte_special can avoid all these
@@ -2405,9 +2404,9 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
+	track_pfn_insert(vma, &pgprot, pfn);
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot);
+	return insert_pfn(vma, addr, pfn, pgprot);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2438,21 +2437,20 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
-static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
+static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn)
 {
-	if (unlikely(is_zero_pfn(pfn_t_to_pfn(pfn))) &&
-	    !vm_mixed_zeropage_allowed(vma))
+	if (unlikely(is_zero_pfn(pfn)) && !vm_mixed_zeropage_allowed(vma))
 		return false;
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
+	if (is_zero_pfn(pfn))
 		return true;
 	return false;
 }
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-			    pfn_t pfn)
+			    unsigned long pfn)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
@@ -2465,7 +2463,7 @@ vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
-	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
+	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
 	/*
@@ -2475,15 +2473,10 @@ vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_valid(pfn)) {
 		struct page *page;
 
-		/*
-		 * At this point we are committed to insert_page()
-		 * regardless of whether the caller specified flags that
-		 * result in pfn_t_has_page() == false.
-		 */
-		page = pfn_to_page(pfn_t_to_pfn(pfn));
+		page = pfn_to_page(pfn);
 		err = insert_page(vma, addr, page, pgprot, false);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot);
@@ -2498,11 +2491,10 @@ vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_mixed);
 
-vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write)
+vm_fault_t dax_insert_pfn(struct vm_fault *vmf, unsigned long pfn, bool write)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
-	unsigned long pfn = pfn_t_to_pfn(pfn_t);
 	struct page *page = pfn_to_page(pfn);
 	unsigned long addr = vmf->address;
 	int err;
@@ -2510,7 +2502,7 @@ vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write)
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, pfn_t);
+	track_pfn_insert(vma, &pgprot, pfn);
 
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
@@ -2518,7 +2510,7 @@ vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write)
 	/*
 	 * We refcount the page normally so make sure pfn_valid is true.
 	 */
-	if (!pfn_t_valid(pfn_t))
+	if (!pfn_valid(pfn))
 		return VM_FAULT_SIGBUS;
 
 	if (WARN_ON(is_zero_pfn(pfn) && write))
diff --git a/mm/memremap.c b/mm/memremap.c
index 30bb99301b18..2b92195638db 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -5,7 +5,6 @@
 #include <linux/kasan.h>
 #include <linux/memory_hotplug.h>
 #include <linux/memremap.h>
-#include <linux/pfn_t.h>
 #include <linux/swap.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
diff --git a/mm/migrate.c b/mm/migrate.c
index ba4893d42618..18d19ef24311 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -37,7 +37,6 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
 #include <linux/gfp.h>
-#include <linux/pfn_t.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/balloon_compaction.h>
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index c1ec099a3b1d..f5ef3d034db5 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -9,8 +9,8 @@
 #include <nd.h>
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+			  long nr_pages, enum dax_access_mode mode,
+			  void **kaddr, unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
@@ -29,7 +29,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 			*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
 		if (pfn)
-			*pfn = page_to_pfn_t(page);
+			*pfn = page_to_pfn(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
 
@@ -39,7 +39,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	/*
 	 * If badblocks are present, limit known good range to the
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index e4313726fae3..f7e7bfe9bb85 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -8,7 +8,6 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -135,16 +134,6 @@ void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
-{
-	struct nfit_test_resource *nfit_res = get_nfit_res(addr);
-
-	if (nfit_res)
-		flags &= ~PFN_MAP;
-        return phys_to_pfn_t(addr, flags);
-}
-EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
-
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags)
 {
diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index b00583d1eace..b9047fb8ea4a 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -212,7 +212,6 @@ void __iomem *__wrap_devm_ioremap(struct device *dev,
 void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags);
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags);
 void __wrap_devm_memunmap(struct device *dev, void *addr);
