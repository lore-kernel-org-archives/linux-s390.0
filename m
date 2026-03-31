Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF237997E;
	Tue, 31 Mar 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946517; cv=fail; b=vEBMUXD45/ijJVnU8V0+TZ+wRwnMVu6v9Qk+ZJlknC9zORQj27avfbZ4uMiuzIpQO//S3gOg5+gFcFtQ89X7fGA7b+pb1bIbCzlqkZJKvYXGYIPj9GDnyyzrg9QNHPdUkZ/RVsOcJL/qx7GK8xhqzC34w9aiOgezpNuxl/ot7jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946517; c=relaxed/simple;
	bh=ZHA+WNInxDTVgfdLZkzcmIdsdVh1P4fjSB96MTPgJs0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Hqrg6i6fA/0UZ/XOoQEovFk/3Rk+t4weJcUYv+ZwyOWc5OZSCfsFctpvh0Avt7c7YHf/EOjIBZuR3VN8TV/UZRSazrq6uk/prTEJHsJfJoOADUzZlpw9DkgX5pVfh+OfWmcBeVaLJskkiydjFv2EuzDwUSDhuhqdeWfFjxYH4ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kj/81wAn; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kj/81wAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774946515; x=1806482515;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ZHA+WNInxDTVgfdLZkzcmIdsdVh1P4fjSB96MTPgJs0=;
  b=Kj/81wAnCtDpfCknmgctf2gJWnUzXSGAXxYsSushnCspIxFYZIRVmuAW
   SI26d6tqeRbygomfb7AvTxU3cKRVqm5WUx04vrLVzJM4QeVY2zmhc2cDn
   zK/TnEX1GybGx4eIOTZDT/co/+5bauEpvfKz1NmkvuIJ+kD2D0G5YJNdH
   MUexw1Ov/ObJTHFi5gSgX1JCam6e3DKNuH5dGxYtDxHgSi7JLCV7uDJ72
   QETRLxEcIIEmpYieuYWP7n8zLW78R+yWdACHELHPjMit/fknvrvAGazPj
   wIzQLKxiGYHTYZShPMBrKqPlZqcDXA5Dwg7jtUja9+iQD646JY0yZpK6F
   g==;
X-CSE-ConnectionGUID: R5ZIsiGpSlaKGa7rIsoRYg==
X-CSE-MsgGUID: 6Bjlx4DSSwaYorK+lWp8xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76142602"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76142602"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:41:54 -0700
X-CSE-ConnectionGUID: uAF+9T4tS2y6SSd4ByQ6dQ==
X-CSE-MsgGUID: +NHwc+6wQkq3qGXvpxoZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221901871"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:41:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:41:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 01:41:53 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kobZ3aXg9LKofRQBTIzAhd5mez3gjCZCvKJ4tjeGnZZsT/RVV2q50uG8jci9irHmo6zEolte/prQIc4QqRRB1HddVYhohcZyaNw8q+7zt8bBbcFxyMc4cPpfaLTQkkaSx3RGDitg2ef6bovxW9aP6UvUDubKQarGsB9QLzTaisKHs+9b8OQ4kVPi0/DaN8e+Rx/WS0xO8hqp5QR4LiylmxMhDsOe0UUR5vGRY6Gaak9Qns8mKKOflU22ttu7iM3fSgwTmO4+yVGUFeTIIjKkSMgbnT++o3N9n7fH6UZ0R/CvW+dHAz6Iqi7buR61onb7ydmaxQDFcSVWmrXgJmS/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4q6ITXGbPJTn8b2SDd1pBpC9oxzK8W1Gar/pDLkfcA=;
 b=ehHIEcdgCG8GkOAa911bbjzotZijrzaYLp7utLVUo6w/wZ+mtNfQP7dnPwVts6uoW78arjLaIbpTDuDlFJCZR3Qki/RSazuMfumBEQCABdVdqLt8JP+jqhHKHKgxPIJECY5VbhQw/hQZPSW9XgJVVuBtNYK7UU/iZ6liXuXS8GzWA5qyETT8voeHOSnvfdNp9QJc06h/rHCvPxmieZihjCcG+UTnYmWPiDCHjYKQfd/Y95XUEdOnMaQwWX46qTOvv2B58KPmeaeOpXXInOt72EcwMePfO/DaZNs5I82Ulw+l/RCgIPX57UN24YtqNr0o5eYrsfO/tYg1ssojBWZXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH3PR11MB8707.namprd11.prod.outlook.com (2603:10b6:610:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:41:51 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 08:41:51 +0000
Date: Tue, 31 Mar 2026 16:41:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [randomize_kstack]  a96ef5848c:
 will-it-scale.per_thread_ops 7.7% improvement
Message-ID: <202603311659.6aa92f2c-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU3P306CA0013.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::18) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH3PR11MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: b93b89dd-2f52-4c4e-2ac8-08de8f015a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 46/v2VYY5rb26S1WMRcRkO29cQ6uznJZwClJkIsLKLWT7TdDBeVGfT6KdAkIfoOY0gB43mnkplmIutAdfqYzeg5erCQaRvDBfOSYDDfPC/1yhiXUMP00PTM0H8qtf1nw7GueoXScbbm2ba2NJSpYmkwXZ0QDOrvqo+EgkRAGQdhQNY5RXhbi2F1+uzIcywzpYGBUQF+iXPpe5dt+cTbmPm1PWACbeGiYpM2/Cg7tqLk8js7zt7fVAG6QtvjMZOClv4clLyn53FFoXhJWUTpD9OjxtHTt0JRiezUNuhtyt43/8/xiKFUmtXSjSPK43Uv3MStUBSK34SRJIR0XxSHXod4zyyBvTG/2VyCgBT4ilSEX1KYDR/RwEXYGtPoGwmKC2lo9JdDRMj3+mHiUMBO2OOu4On3NTgbP0Z4cgCbCBhH7nVQCiU+uQoioTnhl3wcmYX0PuleHohIeKrqpob9+U5OxG25oMaChvfKz5wlWBwEer1CclgsQPUB1NuHOo4XnuENFh0UwFvdU6zMmxg+nSJ78mKmRMlPmjI7sv1SfYp1314pB3Q7OIUaKcnDpQ5yjKpWMq8oTjBeXWDFryTOuGWSdp5kYg8nTAc85TygTwFTW7167bYpIEkm2uubVADVszwLhew4XgAjpCIDr/bz8wJ3cANAb+FKlR4PGX65GwSsdBdRB4LKIN3tIN3bicYq/yR955VWOMD/7xMTVZdKtAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ICKR4qdLoeRdCPsnLyVS2HvrzGRtKv71dx+gZuyMv4UaeVtthz6odllK0j?=
 =?iso-8859-1?Q?YOdLv0yoUjjC5APE+g+L1Dqoauz17jJzkojFH/+5v3aNIVsaf2CjKzGl4V?=
 =?iso-8859-1?Q?Dt328VqtAPHARNLwpJX3PeLf1bv2CP7QBvdPjYKzGsgCR709wQjytH1oM/?=
 =?iso-8859-1?Q?xyOirhZJY8ukBBiRmT40+fIR9qEHJSxsAEDsZ3KI9AiBy9k2+szf8dGkK+?=
 =?iso-8859-1?Q?vCKIBtyHeLOBMSNL5/sGNUwm6X4W14bJs3VMVGUz91QV+vMmXmDsfKQqT3?=
 =?iso-8859-1?Q?I6aKu/HpNOLRQwJvbJFEhePvqiwtvD1zfrsHa4biIW4m0gtMhGB/DpiREN?=
 =?iso-8859-1?Q?CiVnpHbJF34VeX9VwXT81wg7GgUPtpLoE5V9EhbwCdMmpGSkTaDZU9v5QK?=
 =?iso-8859-1?Q?2km2VNvEh2zVFQ5+ceBGlHdeFG+p5F9wFO7LG4ZXJhYtkekzQj1a3jlOwQ?=
 =?iso-8859-1?Q?nq4Mz8ZYlZizGmMvcCsLBQwnBA+wW46JaClWQpuizqkLbtA0kHhEyc/v4P?=
 =?iso-8859-1?Q?fGm4wtSSdRCIOApscc1JQol5LeZg3StT3KVxDsPRgpPIzxoi1eB+A070IT?=
 =?iso-8859-1?Q?CcFnV7lFw5JzulTMr1UxRYZWCC/CjP0JGPxIhrEqAnXMeo4u9DkBIGTKpS?=
 =?iso-8859-1?Q?Kq6rAKc47zIHc7ZaQXiw29I4eMOvu7FtnAp5+o7Nvb+WkmTdnumeO+ZAQF?=
 =?iso-8859-1?Q?92x2nsabCFWvpv7AgdZ3BT/oxjdpF7ljbG+uPnI6Y5JZdMzf+Bo3X3iiN1?=
 =?iso-8859-1?Q?z73wfAHbvnryGoPtZaHry4kvX0hdCcqZbIDYLiVkqyX+D5XX6KJqlk2HFC?=
 =?iso-8859-1?Q?oPcLBD3i135GDKP5eHVv1qE79YZHE1akoyh3gRu98MBFI7JS50//rzQFSk?=
 =?iso-8859-1?Q?SPUaTRdAzHC7h8hFIBPNsUXgFjo4c3Y0drjTr5fNzDw+3GvuCMFldW0yZy?=
 =?iso-8859-1?Q?8mVkBhr4jWTWxeE8VwfyevIYPg/bc+KmpIQN4292mJ5fkKmBns1rBzB3Qb?=
 =?iso-8859-1?Q?8IthE8QHgCPDp3yTeu4jmcZplgxSmyKmlv0z7gDklol6RxtEyb9eBL8NkZ?=
 =?iso-8859-1?Q?Xlxu2kVuY+UOFYir/JgS23Yn5UolWW6Ex8Qa3LRVVyyALc1Djqq8LBdL/i?=
 =?iso-8859-1?Q?K+f5gUPXgv8NXC+m5DRbRtBanZ0rTtHn2fKgbsiPYh1kJtdKa5Hhgwl96x?=
 =?iso-8859-1?Q?8YpSnJE/oW33mzFJFarnXMk6b9JPUp3XL2S2Dv1Nk0fUN2JI3ubNNe1dcV?=
 =?iso-8859-1?Q?7wHXDcF8LpdyNSHo/cb5w5eIazBQ8eYo+uvkUsfyYYpzHroVGK0ji79EqD?=
 =?iso-8859-1?Q?cm3McVBm+henHRrNyAp5dvANN88d14M/2ogUpDGjkMQoTEbCxhXiRX9N8N?=
 =?iso-8859-1?Q?rqDCqdjJyFtBsZOqGqIks/T7j+1YYjx6kjDPh+gS8+fnH0e4J/toS9VoLx?=
 =?iso-8859-1?Q?rkXbAczB5kqs+2d9/aiv/OsycWClXxQpDEOe2zqE+CeNrrV4CsWrLzevoJ?=
 =?iso-8859-1?Q?mghVzf6/07olBD/zkfEGA2ps8JAeyum0zxnIZilSGaFe2dw61ZKI2exbDd?=
 =?iso-8859-1?Q?2hmAdBZcUmbHy8pRPgNE7nnwdcyNpjUlCQguJOZpbd/xNzOY6QOIebE07k?=
 =?iso-8859-1?Q?WZiHyUVdpHYtyVytSrqA2GE1MBsHpI0YU5BBbwCIvvOCF32OoJFHmOs1ZV?=
 =?iso-8859-1?Q?kVmQJekRKjDSM/MQpNYARKqDiBrikyQWzr6Z3UzviLcBmMJkBnP9dxwnYV?=
 =?iso-8859-1?Q?PUOYfy1oNIahBYjdVgJEiLvcI7MaDbFNgRzysWi5Rpc+ZNjO4OjSvRpXLj?=
 =?iso-8859-1?Q?zoRO6oIqHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: vLxHNKJTghrOpP2oo/c9wDaaQkL0et8pqps6rJSx9Rhd/DFN8WJjj7LOxVsNs0qZamBqqwnIdeARfDoiq5xa6WdMouBplKpjDNMs6ezMKn35NXwCxL0z9bquA22Xu1HXagM8roe54saMjMRUCituDZFW8Avo/ykBST75oScFxskRhya0ltB2WmN2jOEkMJ8+BXLF6++QnHp0QjDsg6cRdFI0xMyN3eN63fJrFHmSjkXDN0vvbO47NG/jC/omEpBFoqRJMl31kKj6doTPBzLQBU8LKGSprGNfsCpF6DLqVSTAoLXykWuu9b1OkY42dGU27J5A0eQBAworplAbRHmzhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b93b89dd-2f52-4c4e-2ac8-08de8f015a84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:41:51.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20dSDZALOXLV04r6il04IkAd9hXjm4dKC0EEBkLQHvhbucl/bLr0CoOOKsFPFK7KfGo20ReLauHnobZquRzwsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 7.7% improvement of will-it-scale.per_thread_ops on:


commit: a96ef5848cb096226bf6aff31a90d8b136d99b71 ("randomize_kstack: Unify random source across arches")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_task: 100%
	mode: thread
	test: lseek1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 4.7% improvement |
| test parameters  | cpufreq_governor=performance                                 |
|                  | mode=thread                                                  |
|                  | nr_task=100%                                                 |
|                  | test=getppid1                                                |
+------------------+--------------------------------------------------------------+



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260331/202603311659.6aa92f2c-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/thread/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/lseek1/will-it-scale

commit: 
  37beb42560 ("randomize_kstack: Maintain kstack_offset per task")
  a96ef5848c ("randomize_kstack: Unify random source across arches")

37beb42560165869 a96ef5848cb096226bf6aff31a9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.474e+09            +7.7%  1.588e+09        will-it-scale.192.threads
   7675604            +7.7%    8270154        will-it-scale.per_thread_ops
 1.474e+09            +7.7%  1.588e+09        will-it-scale.workload
     37.77           -16.4%      31.57        vmstat.cpu.us
     60.95            +6.2       67.17        mpstat.cpu.all.sys%
     38.17            -6.3       31.90        mpstat.cpu.all.usr%
      0.96           +17.7%       1.13        turbostat.IPC
    442.92            +3.6%     459.07        turbostat.PkgWatt
      0.01 ± 22%     -28.9%       0.01 ± 20%  perf-stat.i.MPKI
 1.295e+11           +11.4%  1.442e+11        perf-stat.i.branch-instructions
   7450278 ± 77%    +144.3%   18200516 ± 35%  perf-stat.i.branch-misses
   4646936 ±  5%     -10.0%    4180940 ±  5%  perf-stat.i.cache-references
      1.04           -15.2%       0.88        perf-stat.i.cpi
 5.856e+11           +18.0%  6.907e+11        perf-stat.i.instructions
      0.96           +18.0%       1.13        perf-stat.i.ipc
      0.00 ±  3%     -15.2%       0.00 ±  2%  perf-stat.overall.MPKI
      0.01 ± 77%      +0.0        0.01 ± 35%  perf-stat.overall.branch-miss-rate%
     10.98 ±  5%      +1.3       12.24 ±  5%  perf-stat.overall.cache-miss-rate%
      1.04           -15.3%       0.88        perf-stat.overall.cpi
      0.96           +18.0%       1.13        perf-stat.overall.ipc
    119899            +9.5%     131347        perf-stat.overall.path-length
  1.29e+11           +11.4%  1.437e+11        perf-stat.ps.branch-instructions
   7425104 ± 77%    +144.1%   18126281 ± 35%  perf-stat.ps.branch-misses
   4734855 ±  5%     -10.3%    4248990 ±  5%  perf-stat.ps.cache-references
 5.837e+11           +18.0%  6.885e+11        perf-stat.ps.instructions
 1.767e+14           +18.0%  2.086e+14        perf-stat.total.instructions
      8.77 ±  2%      -8.8        0.00        perf-profile.calltrace.cycles-pp.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
     39.72            -8.2       31.51 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
     42.72            -8.0       34.73 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
     26.12            -2.5       23.64 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
     13.12 ±  3%      -1.7       11.38 ±  6%  perf-profile.calltrace.cycles-pp.fdget_pos.__x64_sys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      7.17 ±  3%      -1.4        5.74 ±  7%  perf-profile.calltrace.cycles-pp.__fget_files.fdget_pos.__x64_sys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.86            -0.3        4.53 ±  4%  perf-profile.calltrace.cycles-pp.mutex_unlock.__x64_sys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.39            +0.3        1.68 ±  7%  perf-profile.calltrace.cycles-pp.lseek@plt
      2.48 ±  2%      +0.5        3.02 ±  8%  perf-profile.calltrace.cycles-pp.testcase
      1.20 ±  5%      +1.2        2.39 ±  8%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +1.4        1.40 ±  8%  perf-profile.calltrace.cycles-pp.prandom_u32_state.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
     39.88            +7.5       47.39 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.llseek
      8.77 ±  2%      -8.5        0.29 ±  5%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
     39.86            -8.2       31.69 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
     42.77            -8.0       34.78 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     26.26            -2.4       23.83 ±  4%  perf-profile.children.cycles-pp.__x64_sys_lseek
     13.22 ±  3%      -1.8       11.44 ±  6%  perf-profile.children.cycles-pp.fdget_pos
      7.24 ±  3%      -1.4        5.79 ±  7%  perf-profile.children.cycles-pp.__fget_files
     98.29            -0.4       97.92        perf-profile.children.cycles-pp.llseek
      4.92            -0.3        4.59 ±  4%  perf-profile.children.cycles-pp.mutex_unlock
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.19            -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.18            -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.10            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.76 ±  2%      +0.2        0.92 ±  7%  perf-profile.children.cycles-pp.lseek@plt
      2.43 ±  2%      +0.5        2.95 ±  8%  perf-profile.children.cycles-pp.testcase
      1.22 ±  4%      +1.2        2.45 ±  8%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +1.4        1.40 ±  8%  perf-profile.children.cycles-pp.prandom_u32_state
     26.94            +4.7       31.60 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      8.72 ±  2%      -8.5        0.23 ±  5%  perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      7.18 ±  3%      -1.4        5.78 ±  7%  perf-profile.self.cycles-pp.__fget_files
      4.84            -0.3        4.52 ±  4%  perf-profile.self.cycles-pp.mutex_unlock
      1.07 ±  3%      -0.1        0.94 ±  7%  perf-profile.self.cycles-pp.fdget_pos
      0.06 ±  7%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.lseek@plt
      3.62            +0.2        3.83 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      1.68 ±  2%      +0.4        2.05 ±  8%  perf-profile.self.cycles-pp.testcase
      1.16 ±  5%      +1.3        2.41 ±  8%  perf-profile.self.cycles-pp.x64_sys_call
      0.00            +1.3        1.33 ±  8%  perf-profile.self.cycles-pp.prandom_u32_state
     13.18 ±  2%      +1.7       14.89 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
     18.28            +3.9       22.16 ±  5%  perf-profile.self.cycles-pp.llseek


***************************************************************************************************

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/thread/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/getppid1/will-it-scale

commit: 
  37beb42560 ("randomize_kstack: Maintain kstack_offset per task")
  a96ef5848c ("randomize_kstack: Unify random source across arches")

37beb42560165869 a96ef5848cb096226bf6aff31a9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.987e+09            +4.7%  2.079e+09        will-it-scale.192.threads
  10346487            +4.7%   10828131        will-it-scale.per_thread_ops
 1.987e+09            +4.7%  2.079e+09        will-it-scale.workload
      0.79           +20.3%       0.95        turbostat.IPC
     53.28            +3.8       57.11        mpstat.cpu.all.sys%
     45.85            -3.8       42.01        mpstat.cpu.all.usr%
 1.111e+11           +10.2%  1.225e+11        perf-stat.i.branch-instructions
   4803948 ±  2%      +9.6%    5267473 ±  5%  perf-stat.i.cache-references
      1.27           -17.3%       1.05        perf-stat.i.cpi
 4.821e+11           +21.0%  5.833e+11        perf-stat.i.instructions
      0.79           +20.9%       0.95        perf-stat.i.ipc
      0.00 ±  4%     -18.4%       0.00 ±  3%  perf-stat.overall.MPKI
      0.01 ± 60%      -0.0        0.00        perf-stat.overall.branch-miss-rate%
      1.27           -17.3%       1.05        perf-stat.overall.cpi
      0.79           +21.0%       0.95        perf-stat.overall.ipc
     73248           +15.6%      84666        perf-stat.overall.path-length
 1.107e+11           +10.2%  1.221e+11        perf-stat.ps.branch-instructions
   4903095 ±  2%      +9.2%    5356604 ±  4%  perf-stat.ps.cache-references
 4.806e+11           +21.0%  5.814e+11        perf-stat.ps.instructions
 1.455e+14           +21.0%   1.76e+14        perf-stat.total.instructions
      4.78 ± 16%      -2.7        2.06 ±  5%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.getppid
      5.09 ±  9%      -2.5        2.58 ± 10%  perf-profile.calltrace.cycles-pp.__task_pid_nr_ns.__x64_sys_getppid.do_syscall_64.entry_SYSCALL_64_after_hwframe.getppid
      5.69 ±  8%      -2.5        3.18 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_getppid.do_syscall_64.entry_SYSCALL_64_after_hwframe.getppid
      6.88 ±  3%      -2.2        4.72 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.getppid
      1.36 ±  2%      +1.0        2.38 ± 13%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.getppid
      0.00            +1.5        1.50 ± 15%  perf-profile.calltrace.cycles-pp.getppid@plt
      0.00            +1.9        1.88 ± 14%  perf-profile.calltrace.cycles-pp.prandom_u32_state.do_syscall_64.entry_SYSCALL_64_after_hwframe.getppid
      5.46 ± 17%      +2.1        7.56 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.getppid
     10.78 ±  5%      +3.8       14.62 ± 10%  perf-profile.calltrace.cycles-pp.testcase
     44.13 ±  7%      -5.9       38.20 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.84 ± 16%      -2.7        2.16 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      5.85 ±  9%      -2.6        3.28 ± 11%  perf-profile.children.cycles-pp.__x64_sys_getppid
      5.17 ±  9%      -2.5        2.64 ± 11%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      6.04 ±  3%      -1.8        4.22 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      2.12 ± 10%      -1.7        0.38 ± 12%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
     98.57            -0.6       97.99        perf-profile.children.cycles-pp.getppid
      0.51 ±  7%      +0.3        0.83 ± 14%  perf-profile.children.cycles-pp.getppid@plt
      1.44 ±  2%      +1.0        2.42 ± 13%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +1.9        1.88 ± 14%  perf-profile.children.cycles-pp.prandom_u32_state
      6.32 ±  5%      +2.4        8.68 ± 11%  perf-profile.children.cycles-pp.testcase
     20.95 ±  9%     +10.1       31.04 ±  9%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     23.16 ±  6%      -7.0       16.11 ± 16%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      4.79 ± 16%      -2.6        2.16 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      5.09 ±  9%      -2.5        2.60 ± 11%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      2.04 ± 10%      -1.7        0.33 ±  7%  perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      4.56 ±  3%      -1.3        3.25 ± 15%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      4.30 ±  2%      -1.1        3.19 ± 15%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.40 ±  7%      +0.6        1.98 ± 12%  perf-profile.self.cycles-pp.testcase
      1.35 ±  2%      +1.0        2.35 ± 13%  perf-profile.self.cycles-pp.x64_sys_call
      0.00            +1.7        1.68 ± 15%  perf-profile.self.cycles-pp.prandom_u32_state
     20.89 ±  9%     +10.1       30.94 ± 10%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

