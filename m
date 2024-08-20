Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064618E74B;
	Tue, 20 Aug 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154682; cv=fail; b=kIV5Nr/DtwWpqMocqhGL8DGFD2EhgpLNV+m+jyQrDbQwluQGFw1eqUBwqdeWvCTaO9hPJGN1dh3Vj3KKCtNz1NsamcBcmRkhrkD3Me2wjgMKhhCphfWYBFDn39NsNRnKvGIVucgdd2dRc55Si4Gj5MNI2Eevq0kCdvSNh1xbdDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154682; c=relaxed/simple;
	bh=oJQnd2mX23fTOOKozZx3TsWTe3WBT51cle0JrtWcTlw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y10aDOAAhw/XB0Q1RXhJrBdgfoyAobdPtWN49uVx419ktW9O7UX6SaYq/7WfE9M8PMfMTaqIHjWgYFBakDq9I0LyMW6a81LG93fkDII7L1d1OmR7DEnF/7PPUDbiNmzNFYQFTtXPmtxzny2dzKdb+KN+rP7KoGvSDJ+Mhug/a60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hu1hLVCb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hu1hLVCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724154680; x=1755690680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oJQnd2mX23fTOOKozZx3TsWTe3WBT51cle0JrtWcTlw=;
  b=hu1hLVCb5sVeyRfPTc4CJFHew/KGNY43IpGLKstwQiqgBpNNV1+vdKQd
   uNtZYSDFloNtfupqIJNxVGWsy6Vopi1EH6hNNhpYcF6ny/FtSWz7+4ccm
   gFd1fCK9eNb9FKkgYrERvsqeqTdgsh9dT0aY4RM7ZvBnXpm9draboO1Bz
   12W3itW17fqjIlvLm56tzTPlDPrMJB1jqhpZBTy33Z6dQxuFnddUre/MW
   xlDG7HpLG0adoVP4399ArSKeC4ddL/50tVHIavMqG/DGq9Sky65yM/29e
   u/8Myg2iZ4TB8QMhwbf8gPlFBHJMI+62oMuUTWE7VIYkbiAv26Npx7iPy
   g==;
X-CSE-ConnectionGUID: 8nIqp0ysQi6veD5mteirMg==
X-CSE-MsgGUID: lC2vzMC1QFihLzCoNkxFxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26316641"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="26316641"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:51:18 -0700
X-CSE-ConnectionGUID: RdvtWzb1QxCvvxYhDV+sdg==
X-CSE-MsgGUID: PxEJ9Hl3RTKJyrGvkOE+KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65567714"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 04:51:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:51:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:51:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 04:51:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 04:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KteMUsyjeCydRS2/9oPDeLJHGmETSrsPFv596IrpCUIOCyGjREXCZ+dOIhzuj+mQ5zKjVgnapyqtPiIYXaHa2lNPmkPd/PVi7NbPg6Q48VvzgU5BC1BxcWQ+6KcBSoicm5CFUH0rjx9bveyPLa/qjXtuLDuYKsXB/SKrgtuB+EiW7PYhrK2lc3IdvMHJuLcMLSZACDegDqy191KhWwIWAorugDoEtE6fBNG+DZDQr4OdWK9WTbzvFN/rCdi3jskftt5iImwTTC5smGiTIGVbYLnOk0WaxuloFdyOum8QmmZpwJX6R8evOVNEVuBbFWQRg35kT6789E6hM6nj9cqA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhtbbLXGCUbGy6Qr5yZfdL4H/NwhQAQayT6RZ+OnpRc=;
 b=plzLO5M2pJfOjwaGiUhGq/lTk5GByO4e1M00dOZ+WYVr2yHJB91kAphSe7BjkdiGweelcovKvVU/WRn1+27pJc1P1fucepg2QK80ReUEHd0kAFGxglh2rEQynW+0rYb41/QlDrWse+WdJYzFpO9GDhkb/gJCgY2Lwso1ABIUbDZURWwbdjn2C10iRpD2u/1IZXDCIBRovaoa5payE43sPd2008rI66pgjBAS6WSL1SOhQUak9azAg9wvpZsZijwtUqEZJeN0+alDzSr2S2lY6qXl/yTIpE7y/o0kXmKCn53dDXtoSWxcK19VHd8t3GWJs0Su9rjCXEIMg5pbXLXNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 11:51:14 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 11:51:14 +0000
Message-ID: <5e5bb753-9d6b-4e6f-8b02-ffa2cae1a4f7@intel.com>
Date: Tue, 20 Aug 2024 13:51:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] s390/iucv: Fix vargs handling in
 iucv_alloc_device()
To: Alexandra Winter <wintera@linux.ibm.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <linux-s390@vger.kernel.org>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thorsten Winkler
	<twinkler@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>
References: <20240820084528.2396537-1-wintera@linux.ibm.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240820084528.2396537-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c75cc8-5906-4d76-973c-08dcc10e64a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzR6MW9SZW1aa21DSXdHUVhRT25PRUJ5a3JaWXg2MlgzbHNlOG9Wd2xmWkJY?=
 =?utf-8?B?bkJ6Y0RZYlR2cEZYSmZOK0hyMVlHR1Izb2pYb292N0ltemQya3V5bGFHZXJV?=
 =?utf-8?B?VERvK1ZWL09nbDFFMUpNVHZtSDlGdmxpMG00VUF2WWlaamgvdGpEUThEV3Yz?=
 =?utf-8?B?bDBQZzE2WG9rSzV2a3RqVEY3SkY5eGR6TU0vVGR1RzJaYjNCWVEyUmZaVnBp?=
 =?utf-8?B?bXhJZGx2aUlYbzFVdGhkK0JzM2hqRFU4YnNNQmJ4UXVMZU5sWHQxQVRhVGNq?=
 =?utf-8?B?YkczUlZNVm90SEhpb0V5M3RBK2N4NGRETTR2SWZlYjlxcE1lYzRINnE5UUlO?=
 =?utf-8?B?VzdUcEM2L0VzMUJIbzZGajlxSVpsbnIyVjBTdXllZzBaaUovTnJkSmMyWUhK?=
 =?utf-8?B?eEpvaVNCZDRiMGcrT0pKdnlIQjI5NFg1RWc0OC9ROWFiTUlVWmRDQXVKUiti?=
 =?utf-8?B?Ynh1ZHM5UTd6SG9aQXNxeCtqWjU3dUdQUU9DaWxlY2NkSVc0U1JiUTFheVh2?=
 =?utf-8?B?cE1jRnNUQlk5bjBkRURiQkIzRnJDNkk4OHpXcEFvVXJUdGVlOHk2M0hPWjZS?=
 =?utf-8?B?aUViOS8zMWJsRlA1YlFXLzM1VjlxeFRqazRWdno1VzFxZmR2OGNwL2NETG1V?=
 =?utf-8?B?VHI0VFNMWmk1MTNhUzlqVmk2azBkd090T0F5YU1sMTkwNkdSelFZUGNGQ0Vw?=
 =?utf-8?B?MkFsc2IwTFhzcWhrY29UemNuRzQ1czZrL1J6RklucWpmdzh0dGpVajI5RTRW?=
 =?utf-8?B?YkdTbUV4Q3VNTXQ5YzF4dFZwNEs2SkxKUWZTb2laYTFPUk92dXlMOUZwZjFY?=
 =?utf-8?B?NnlTSEFQQjlnU014RTh1OENkZkxJcFRMTHBTTTNnaE1PUStmMEVITmFLbGxs?=
 =?utf-8?B?cG1uY0M3WS9DMlFYbFFUNnl2eHVNdStwN2poUkJVQW5wTUdjUWNyREJvNGQv?=
 =?utf-8?B?YjNmUnZ3Y3VtRUpjalQzVlByZ0UybUpxdmVtUlRscnlOaHBzc0ZYSnNGSkxY?=
 =?utf-8?B?dFZNWTNoQ1dBVTd3VWJzTVdHamVzV2J6RC9BU1hDdTF4aHozT0R0Zi9HS0wx?=
 =?utf-8?B?bzZkTTBHcElZRlhLRXlUTWhOcE94SXVKem5GK2ZkYTVsdDBTbHNtNEcxRkdZ?=
 =?utf-8?B?RmFhYzdldlBYdStDSXdvNkxxK01LanVlSUdVUDRWOGcyMG0rZ2svUzdDaUhq?=
 =?utf-8?B?Z0tZK0xjUmZMbm5CMVdraGt1K09MZXM5SGJmRUlrZjFTTkpEcWYyZDlObHF6?=
 =?utf-8?B?WjJaT1NYM3ZTZC9vSWJiS1IxWjZpQmZlQVloaDZWVTFjM1FwSkU3UUw5OGNO?=
 =?utf-8?B?MlNTclBRRmIyczkrR3JXSFNUTUVNU2htZzhSOVZrQm9pMU54b0ZSd0czNUhK?=
 =?utf-8?B?NS9zWTFuVUJ3MlBXVEM5NmV0eGxzYmF0emcvbnhJS21QNGdKUW9zWnQ4VGV5?=
 =?utf-8?B?UCs5ajdvUTVlL3FzV2lZdW15aytVUnZidTVGajErN05ZUXdmWmZkRU0wK1R4?=
 =?utf-8?B?aEU3YXA5czQ2dldOSWFTNnlON3hxVEEvVTZmNFRxdmptemxxMXdtR2dqZGk0?=
 =?utf-8?B?TVdwaHhoY05wYy8zdUpyb1EzZGZBUVIwbDIrcU5sc2p6SVFkWkNZTEpGUzJS?=
 =?utf-8?B?dTIxWkhqSStFbC9wOHY0RUR5WE5TcXR1KzNMcmpKNjRZL3RIako4OFF4eWdr?=
 =?utf-8?B?SUw2SVphTHpxT1hHOXhSYWNlb3NNYi8xR0tHR1VQaTdrSE1TdnR4MVJQRm96?=
 =?utf-8?Q?T0xmt7WXubYZOEK+7xknWvRKIiqeLE0lrDGvZsz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndZbGVwT2ppNWhscHRjL1BkbkhYeDkrcXJqczFtVUpVUUMvaEh0QmU2cFdU?=
 =?utf-8?B?S1pGVVAvL1FqZEFJMTYyVUh2bk9YNCt6eStLdXBXZTIvaXpxSWVpMXRGMkVM?=
 =?utf-8?B?V0FyV3Q0ek5VSGFRMTJRK1N1NnpnNXRXWVpJT1FoR3ZraW1QUFJoRjhRR25E?=
 =?utf-8?B?NGF3WVJrWFRNYmNjWDNsUWRFUUhWZENlRy9xaWNHTkdCdFd1enhsL3p0K2ZJ?=
 =?utf-8?B?Y25SeEtoelhjTzk1K25XZC9reFk5TXZEM2NCRGtpTkJ6YnQ3REtSY3hackR0?=
 =?utf-8?B?WFBrbmlKWU8wbGNBbzcxVFJpOW81cG1KekJkYWppTHpaaFRoNGJNM2hIOFRI?=
 =?utf-8?B?QVJDcFBUcmhLQW50RWJRLzJpbkgwRUM5djNIYVVaRDB3QzdoalFjekRqRjBM?=
 =?utf-8?B?eW00enFSMmtlQzZRZkdKRUJOQUwwWHYzZjdWdE42VWNyaW5jclQ3VGRnUWtU?=
 =?utf-8?B?N2R2MUFra1d5NHVWYTd1QlVWeGJ5SUtyN3Ruak94OEhjM2RWcG16SlFva3V6?=
 =?utf-8?B?NnkzZFBoaklXaVRYNW1jTVJuR2JaY0RkRXBxeExsL0tUWG9TNEhGMkoxZVJq?=
 =?utf-8?B?UEZnMHBNbUdIdkpzU2IxRVdLN0NHUW1ZazhQN0xZN2NSNzVxdlVma3BqZHdi?=
 =?utf-8?B?NlBleEw3RUhGMTdnQ0tEMEVKTjg3dE5OWTJWVVhSTWJsWGtac0VsUzRrdTZz?=
 =?utf-8?B?SlJUZE4zMnJKWW1senoxNWxBNVFSZDFpajlUU0x0bUdTSEc0R2hhNVhYSWVi?=
 =?utf-8?B?cnpQSWVVSEM1dGh5UW1aWEZZQ0UwWmd2c2JlU210RjlrOUhibGFHWjJwQ3do?=
 =?utf-8?B?S0JtVENKcjBKU1VQK1l4ZEtpNmpMZlhIYVE1b3B3Sy81S1Rkc0U4UDJJbnVK?=
 =?utf-8?B?Sk0yWC9ieDVGVi9yOFhtK1J0VWJYRGg5dFNmcVcwVy84ZzJvNk1VdEJQWWlB?=
 =?utf-8?B?eUJPaUY1WkNTQWh3UUkrZFhjdDBNZFBkVWd6RGQxa2labDV6T2d2Vmg2enZU?=
 =?utf-8?B?TDluNGh3QlZXMlpMbmk0YnNycWh3QkNLbFp0TEsxZVpHZmJGeHZWdlFqTTlO?=
 =?utf-8?B?WWxPcG5VdS9hUVBmaWk1NTRpcFNMdjVoVjgzS1E3K01UakZ3cVY4SWJyYnU3?=
 =?utf-8?B?RmJ0T0t1VjFLSitzTmFHbUprNGVaNnpWSkNhYTRDY21CLzlweEFMc2RuVjZr?=
 =?utf-8?B?ZDNyRHk5N1F1aU1zMjlySTZoaTVjV2FLUm9FclFpVXh3N01ua3Q0T0ZjRExj?=
 =?utf-8?B?YTR1YVJXRU9KbThMWGovVzQxdHhGZVJBSEhVNDhWWW5lb2NWNGo1U3VzSjJG?=
 =?utf-8?B?SDRTSHpLUVlPVjJZVHNRWVV2SThJek52c1NrVlB3Z1VWQWs2SHUwM3lmeGh2?=
 =?utf-8?B?OEV4dHpMNm5RS01CYlVHcGE0aTkrVWQxRCtZTUQzNTJudHNUc1o0MzVuQTBF?=
 =?utf-8?B?WnZESGsvYkdJMlVzWnRZakZiQ0ExS1JaZWVQN2F4c3hldXF3QTBPTWt4ckdr?=
 =?utf-8?B?emVieU9CVFdaZlZtNW5vNGQyaENNVGtLMkRmdDFPMzNyaS9sZlZnZFFDRWli?=
 =?utf-8?B?UEJRRnMreWo5Yk1pbFUyWnVUL2lFNDZWQjZQSVBseHpISzhGRnFBNmdpTmt4?=
 =?utf-8?B?b1NvSUhhMUFMbkxZMTJDUVZ2TnJ3bysrMkpURnVqUEVzSDJ4MzFnODhlam1s?=
 =?utf-8?B?V05GUXNZZVg0ZFhmekxGTWpMKy82SVhkamRpczlWaXBxZDBNUkNsVWM0blB6?=
 =?utf-8?B?TFc1dnNLVzAyTTFsOTh4YnVOSUZnUlJzOXE4eWp2UkNkSGNRbWJ6ZmNrUU9P?=
 =?utf-8?B?MnJmUWxXYjhkZWFmR2lrUzRhamUwMmQvTVk4L29zMlJ1ak0vWWxrNzluQ0VQ?=
 =?utf-8?B?Y0FSNm12RXJZaHNSQXFFWnUwNWRlTU0vOURpUTFPUE9Cd29KeDd0Z2JheG5q?=
 =?utf-8?B?N1BzQVdaTW84SlRrVjEzRy9QSWVaTnVtdVRwOCtoYmVmZ2I4amJvZGpYRGN5?=
 =?utf-8?B?SVA0TEQ0NzJmUW5aK0JrZnB4Z0RVSWdCTlM4bkk4ejhQS3BxcXR6Tlc4R09m?=
 =?utf-8?B?V0IwRVhrM0FHYS9ETzJUMkQrTkNldVkvamVZcEdUMW9YZDI5NUd4SnFDODFO?=
 =?utf-8?B?MnlyQjlVbWFFelVPVzUrU1k3NUozMDgvTnduREFzbXNUd3Eva0tFUktwaU9i?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c75cc8-5906-4d76-973c-08dcc10e64a6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 11:51:14.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPFR5EfJ1hOVhmgVEgHsqlIEOwN90vY4tj52VxS3Vi54qitC0Vdr22cZYxc4XzJPh12mWk5XGfCOT+DSQqnbVylTTaSGOoLD+FpDzSAN6Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com

On 8/20/24 10:45, Alexandra Winter wrote:
> iucv_alloc_device() gets a format string and a varying number of
> arguments. This is incorrectly forwarded by calling dev_set_name() with
> the format string and a va_list, while dev_set_name() expects also a
> varying number of arguments.
> 
> Symptoms:
> Corrupted iucv device names, which can result in log messages like:
> sysfs: cannot create duplicate filename '/devices/iucv/hvc_iucv1827699952'
> 
> Fixes: 4452e8ef8c36 ("s390/iucv: Provide iucv_alloc_device() / iucv_release_device()")
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1228425
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
> ---
> Discussion of v1:
> Link: https://lore.kernel.org/all/2024081326-shifter-output-cb8f@gregkh/T/#mf8ae979de8acdc01f7ede0b94af6f2e110eea209

side note: that's nice that you have continued Vasily's series as your
own v2

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408091131.ATGn6YSh-lkp@intel.com/
> Vasily Gorbik asked me to send this version via the netdev mailing list.
> ---
>   net/iucv/iucv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 1e42e13ad24e..2e615641a4e5 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -86,13 +86,15 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
>   {
>   	struct device *dev;
>   	va_list vargs;
> +	char buf[20];
>   	int rc;
>   
>   	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>   	if (!dev)
>   		goto out_error;
>   	va_start(vargs, fmt);
> -	rc = dev_set_name(dev, fmt, vargs);
> +	vsnprintf(buf, sizeof(buf), fmt, vargs);
> +	rc = dev_set_name(dev, buf);

would be good to pass "%s" as fmt to dev_set_name()

otherwise this patch is good for me, so please add my:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   	va_end(vargs);
>   	if (rc)
>   		goto out_error;
