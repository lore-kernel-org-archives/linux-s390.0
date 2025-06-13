Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6042DA751;
	Fri, 13 Jun 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805255; cv=fail; b=K4xUc0/aCAu1QS6mj4mf6rmbWxSpP6iE+HOIUON7QKVJ3xF8CVubpEO5/EpdUc/NXufBm4Xc++5tLDxILKZlKjPrXirp+1hIyv/mNGGb37e/1Sik8q2SuIF4WGH0mNTUG+Yutbkm52yAZPGRDJIOG8lyFfe85UVgMA5ZLx+zk2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805255; c=relaxed/simple;
	bh=KL2KcSoNJSdKU4OZmdRgHiQ6QeHbJXVnqcGzziHQI14=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=h/QNxvpPH1Gnq6ALfQ4Tgr9BvyiAryT/evudiSzHb2LiI7yNH2eJ9W48uR4J8odVrZBc7DwpcXr2T8p5kFFDINBT1Q7iY6Lh3bFUeTli7xIqifgG9YtJtT1JoGAFTvipKOsxZD9BFlYnmX9pssNdtRNlGon0skzqCVedLLKOGt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4Fzn2kW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4Fzn2kW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749805253; x=1781341253;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=KL2KcSoNJSdKU4OZmdRgHiQ6QeHbJXVnqcGzziHQI14=;
  b=B4Fzn2kW97LiCDYud71yi3wq5+nvVGG7nHA74h1SNOLQ+dELdZd+3Wlb
   R027H4Od90DhyBMU94y9YpTvXGDQGYPlUtbjhuestbI0tI6TLTP5xMOya
   q3p7lnXKfBTk6L2oETffUj6rS7lzDd8owfSjg3Y4q6mLDbsstrfjNH02J
   5yaQMYwjGlqn3UALkqFGxYnbWeZ/Y1rypp1b4Hmqp5dCsvcYnBCrAOIVw
   Fq14UzcG9HZ2GCw510hSN+E1Yv3+YM1P8lbJutLL3G1dwW3xKXGCIMZT5
   8oOE0CUvL1qQAlcLbcZe/3I+7ESLqorcuV1Ml4EpH5Ss67Ce+aTjp8/R+
   A==;
X-CSE-ConnectionGUID: PhxfWApsRNucoZ02gBQNow==
X-CSE-MsgGUID: gU/rpLrYR4GQrZ43RJ5rhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51731773"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="51731773"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:00:49 -0700
X-CSE-ConnectionGUID: 6QEBRjQmRA+4fXagkF8EhA==
X-CSE-MsgGUID: SwR2hsttSe61JsIn+98xNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="153065325"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:00:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:00:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 02:00:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktxyCfgl+b5RIU2tPV+bruX5PKGRhSFPnAHyclvjTrhVpWbkJPzeNj+nRgFvkv7ZQQuy79E5X/8/F+FXV0TA3IFtmaQpsf8G68Y90iMBke1fDqUmy+fA+UA7k3DMygDPL6rbNr8UrSHlu3Nt90xlQlC3+WXUdpOg6JrKsJ0yvgrR5EHvgmNmVr0xyR217En71lthhongj/bFPK68cM7xgMMXf09xEZDIlHSJWSJE9NNUd4eMhRXI6Hl+G6Ud/C4fl5e19YEcC8a1sjax9h11ZUba7g7aXh6W6sU4CsDZaXE61hgJIysstFemrjxurZoj8kUxEbJ1ZO9KUy4Hx7slqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytzn7ovGV/JP+VQ9iW6jYypLpo61No2V6TKTUvKZnzc=;
 b=jXbSUIgm1v07Zgqce98nSFwU7eCgmFInSVtqAG0H1Lzkc2FGIGTyq3KCMH+UG+TIuBfrG6mOplX2ewDjwgSpl0TkD7Gjb1Y4EsSLsxMdovkFHcmY5gSKLfX3GmMbmy0hT8MIdJ9Fb+qf32HuB2cVxYJSMdBEGeuIgl+zQNXBdN2mCCA9js1dVMVIFyC0m8rnBkEA+MVVaMzFNVtazsLAQ0/RWSntEJrwzeEnBGW8Fn7rkVO0oQLtjDxlH/JTsmL9FVtq8yCgq8uZQWqXEoOiF+55jneXh9MAWvLLX0Nx3YXYj8cMbStftMxVVWx/LWbJOJiZlbrSb+2TO+QbFVk2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 09:00:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 09:00:32 +0000
Date: Fri, 13 Jun 2025 17:00:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Zi Yan <ziy@nvidia.com>, Andreas Larsson
	<andreas@gaisler.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "David S. Miller"
	<davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, "Johannes
 Berg" <johannes@sipsolutions.net>, Muchun Song <muchun.song@linux.dev>,
	Richard Weinberger <richard@nod.at>, <linux-s390@vger.kernel.org>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  4e92030c05:  will-it-scale.per_process_ops 4.0%
 improvement
Message-ID: <202506131621.3a42eb16-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 4616f7b4-9847-4baf-e9f0-08ddaa58c0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uPZ1xY51R3JS2gbcdlBOC/JPUQFF6LRftLn+6T9Rd4A9rYADXCj3f1Hp83?=
 =?iso-8859-1?Q?Lj5GiqRD3y5R/A6d61Md3NfcPMUI2XmrylYGY9xWsU6LEXgigB8K4Q6dgA?=
 =?iso-8859-1?Q?fq9LS71Dd9RobBzpQ6XgVjUQxgEVLULzQR3CT7MbL0XJg43o2pdojSuaGJ?=
 =?iso-8859-1?Q?3mvYPw1r/xLWxyZFSqjign7L50eKlWPIi65rUON+LfTxRStYVtKiq0J6S8?=
 =?iso-8859-1?Q?tVFHa9Vl1zKwRdyJCviBjf3ETo5tccpxG8Lw3fVWpTfhINgnIGf5WCffcI?=
 =?iso-8859-1?Q?5CfuData/R+Q+OAPA9QbVEiPbbHTqIXXIWcoa5nx2g1pLpJfB4tDViPQaC?=
 =?iso-8859-1?Q?INS+UWxCBO4Ot/14xmKBymYh1HAheiSNdTPJQg7r2hRh1KBVaZk/2aflm2?=
 =?iso-8859-1?Q?mS6d7BoZRueLTGR+69GiOeOKTj8dNwgCq+xMeQ1kftsnauLkEuZY5Khvof?=
 =?iso-8859-1?Q?LilvHg7XU7mKQ5PajKskEExnqRjqG6tiFtRx/2uPrtftUQBQyAcCENUWIW?=
 =?iso-8859-1?Q?4+4jaDQ1hpMYgAJNFQs77axuhTPcfIxo8QmD4BMEoguWBTpz1jO4jyIixu?=
 =?iso-8859-1?Q?W5krERHiOsX/HjSUy9RD019f1+yCMppHqfSrgF0bLIkkp7rjq/Pr9J4pVm?=
 =?iso-8859-1?Q?GndhA8a6P2gVLvbQ4vv+WhSk6HFYYpXQcGrLVf0mthN7tHYbDlPAGKn4bl?=
 =?iso-8859-1?Q?A+Brkx1qY8xAhQQUoNqSvJeq4nnzWr4cCDkZ32P5ynIKUgQ+pylJRxzs+6?=
 =?iso-8859-1?Q?pCh1qrXRahqsm44HEx1D1ezE6C/Y95/C/tvi300bVs6Pv4xKOhS2uyAAAR?=
 =?iso-8859-1?Q?luX9ZgpItjC762O0wCqN6b0d1oPMo1hAAFmTIa8EZy/N6wrRwwtaQiPfNp?=
 =?iso-8859-1?Q?WKco46IKWzNwojiL2uec+kH4iD5AgzPPazbgexeTg8uXjUYT5yZG0PywOb?=
 =?iso-8859-1?Q?2gLr6nnfKR0uWvfse98T7wNuq2hx2g2Q5ment3o7ZCztttRI36TJYFfNSz?=
 =?iso-8859-1?Q?EPKfuzHfv9N4d4JX9D67HN6l+GF7e4FK7gNlqKpd/h+RpLlTY4FT4P0uTA?=
 =?iso-8859-1?Q?nEpReRRqG4HxqcYulzrUm8WarwoPuG7LAdCRKpL//VDQPAh0jslfkiXflP?=
 =?iso-8859-1?Q?WF9rdGC1eQ77Ear6Zhq0C4261RijNx4ez+EGZSTI6CEI2FgakdPx70mD8x?=
 =?iso-8859-1?Q?f6U0wma32epa1lV/KeishT7GeOeBMK46XyKNlPlD1HimUWflCAD+/tMl81?=
 =?iso-8859-1?Q?qQBn2Gk0IuSPfDrlZV0rvHfakCY9VYx8LSYyKx6x9JQ12qd8QpYq5ULR/s?=
 =?iso-8859-1?Q?TiitNxMOFSDTUb7tHVffbIySTKuInSetmMGCOODNtkku3+XD7JVvsi5POB?=
 =?iso-8859-1?Q?00OHd8TVJ6N12hCQ7AgR3bdzAadgYoNGpcHvv+8BOSPknWoO2lD9Cl6e8P?=
 =?iso-8859-1?Q?2jat6p9xPQYI55NW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z4PTlSGLvQx+/i4SqtXFutWRXsTwZs5Pe/U4F5Q1FEPh6PTemMPe/c506Z?=
 =?iso-8859-1?Q?MRAzNCs2Yd/Uu8pHgqm/WbVloDDKHGOsCXIJMx2BVKNu26jtAYGpYN/E+5?=
 =?iso-8859-1?Q?/dh3JW+j0J7SlmiIKzkb8VuS3amAASnG3eRBrTZdl8jSrYT8S0QY6emmLj?=
 =?iso-8859-1?Q?VkDeQAVq5XQWj17CuzPJBt12Pg+FoUPeoT9wyWCfmTvJtD3u2acVb3FCZw?=
 =?iso-8859-1?Q?tycJuC+HkNjAf/743dd9akGL8eRUDmWkDcK+PvHg6FMsw+FeD8Ha0/V+MC?=
 =?iso-8859-1?Q?9sYWxYEgqq4Rx+sWcRMumvWdQtAXLHjibDz6q8b4KsW7+1nM0ehOu4HEtz?=
 =?iso-8859-1?Q?USqHHi5nnoo3rIFzBD7OgZyDk8skzCHbPuJ5lC2PXCJryrKkoZ97D27GrM?=
 =?iso-8859-1?Q?B5A7qpmuRkjVBXHK2ZEl9UTwgTY8dS3tqbCdpbqZ1ygLhlltosshps3eRK?=
 =?iso-8859-1?Q?uJstow56fAIr9b4N0UzhYabNw7WwznCMLFX0Ugu5RHNP7PbLQyqYbGgJ26?=
 =?iso-8859-1?Q?y1pQrqIbSNNf7zFgwI9MLwuYrTq/4vsuDyneS5+Gu88kEclV1TKS/iyhf7?=
 =?iso-8859-1?Q?gFjg9U95anuu3GMDXlDK6orDQ5sSKTmwz0b6T+0al89UxBq2Eujt6nSLfc?=
 =?iso-8859-1?Q?15/skU48Pyr00SEYscZ7yonfSZntX5PtF7t/NdY4v25NZ5x4dstL6vxDRu?=
 =?iso-8859-1?Q?y1HsrMQwW9d3Fj4oDPFw/WgTaEAQbQHmZYki2c7Ka7yIeKFA5tUoRuAnuI?=
 =?iso-8859-1?Q?WtvwPFBFPhlVUKLfPt9Ob4j4pamAUvHjukAfXXA8i0NhR/ECJkohY5RLbw?=
 =?iso-8859-1?Q?Lye+En6SSM02IJGcz/2G8BEneilM9gfNpWn281rM3GUcNXjwcsNJLtMWSR?=
 =?iso-8859-1?Q?HtnOlxz+8gn4UHEdDPD6gkHczGTXQCOx4t5s9YR9bzUzpDhuZzdDkll6R0?=
 =?iso-8859-1?Q?Kj+cCtDwNdRkmGe4+tp8oHXqb5EF8+bMJn1xa32vj3AoXt+jCj44hsDqzP?=
 =?iso-8859-1?Q?obRkIgrZ8S00l2rPg/+EDRvgV7EXEFEcj+L9B2byCxkjSWCkAIM/AZe8KK?=
 =?iso-8859-1?Q?0FN0b/cQMBlMRH6NyYDu3H8grY27RqI8FR8pO/Jl1XVoDcOtTeNjjRdSFc?=
 =?iso-8859-1?Q?AQCRa8dxNncBZA8Eueea5+htMYA5PbECZGRLwoNVUvej6aITZCbuBb+7Do?=
 =?iso-8859-1?Q?3EikUPGFssUzA78M1HdUBGkPY+TAh99R66V7dO9tqUD1sw/yiE2EOjF7zb?=
 =?iso-8859-1?Q?1M4Kp58CzuDOu31L6OTRqPP6UScj5s/Vl4vCp1u9Bkx0g+LUPRpHVIHVK1?=
 =?iso-8859-1?Q?Xbxzq8b9uIGqa24fkjpVqXaePCZKd2kszYPPAdZXH3hbFvne0u3l5sznYh?=
 =?iso-8859-1?Q?Uk8/cW1n759Qk1w9kdsPrkhlkQAxEibvtgCoQrszVIwqpgnBBFS5D0BtAJ?=
 =?iso-8859-1?Q?zaRtccM5/8HJGxAr2BWxuW5L4i4Uac/Rukuwb5u+m/WjCwGvrV6pWQ/gG1?=
 =?iso-8859-1?Q?+zkeu+iQ73ucId37m7PYRLViMUXrAF4eDq0E3XAzowBSoYPY4amlp2c9c5?=
 =?iso-8859-1?Q?p5h/VjQNLkQZcV2wWvrpCyHA/Suu/PWLgMd6P1IsrEWDuJbvZwPXsHU+LC?=
 =?iso-8859-1?Q?xdmHdjRoybFEyaE98JCfp9jWJg3srwf55W+DSkAubzDChv5hkWbgDOHg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4616f7b4-9847-4baf-e9f0-08ddaa58c0c7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:00:32.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6ol8kkk3x8L3sSswRM5lVNVpLqu3ekTzKoXVKZg8WA6na3zr9Z5gobxIaBxlT/c76/dcEzAecxiWqjSTCFN8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed a 4.0% improvement of will-it-scale.per_process_ops on:


commit: 4e92030c05dc351e62955ac1aba7233157f49b78 ("mm: set the pte dirty if the folio is already dirty")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: tlb_flush3
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250613/202506131621.3a42eb16-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/tlb_flush3/will-it-scale

commit: 
  f83f362d40 ("mm: fix ratelimit_pages update error in dirty_ratio_handler()")
  4e92030c05 ("mm: set the pte dirty if the folio is already dirty")

f83f362d40ccceb6 4e92030c05dc351e62955ac1aba 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.77 ± 20%      -0.2        0.56 ± 16%  mpstat.cpu.all.idle%
     26.23            -2.4       23.80        mpstat.cpu.all.usr%
  16365335            +4.0%   17014745        will-it-scale.104.processes
    157358            +4.0%     163602        will-it-scale.per_process_ops
  16365335            +4.0%   17014745        will-it-scale.workload
   8282448           -13.7%    7149139        numa-numastat.node0.local_node
   8350777           -13.5%    7220840        numa-numastat.node0.numa_hit
   8668303           -13.6%    7493522        numa-numastat.node1.local_node
   8707609           -13.5%    7530401        numa-numastat.node1.numa_hit
   8350002           -13.5%    7220413        numa-vmstat.node0.numa_hit
   8281672           -13.7%    7148711        numa-vmstat.node0.numa_local
   8706793           -13.5%    7529384        numa-vmstat.node1.numa_hit
   8667487           -13.6%    7492505        numa-vmstat.node1.numa_local
      0.01 ±  3%     +10.0%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 23%     +91.2%       0.04 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.66 ±  7%     +12.3%       4.11 ±  2%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    536.50 ±  5%     +45.9%     783.00 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
    306.33 ± 18%     -42.8%     175.17 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    408.17 ±  9%     -35.5%     263.17 ± 32%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      8238            +2.9%       8473        proc-vmstat.nr_page_table_pages
  17059957           -13.5%   14752681        proc-vmstat.numa_hit
  16952322           -13.6%   14644097        proc-vmstat.numa_local
  17203283           -13.4%   14890117        proc-vmstat.pgalloc_normal
 5.235e+09            +4.0%  5.442e+09        proc-vmstat.pgfault
  17050640           -15.9%   14343976 ±  6%  proc-vmstat.pgfree
      0.41            -5.4%       0.38        perf-stat.i.MPKI
 2.709e+10            +5.3%  2.853e+10        perf-stat.i.branch-instructions
      0.38            +0.1        0.45        perf-stat.i.branch-miss-rate%
 1.014e+08           +23.4%  1.251e+08        perf-stat.i.branch-misses
     73.09            +1.7       74.80        perf-stat.i.cache-miss-rate%
  73925751            -2.7%   71898892        perf-stat.i.cache-references
      2.14            -5.3%       2.02        perf-stat.i.cpi
    177.46            -2.6%     172.82        perf-stat.i.cpu-migrations
 1.334e+11            +5.2%  1.404e+11        perf-stat.i.instructions
      0.47            +5.6%       0.49        perf-stat.i.ipc
    333.01            +4.0%     346.43        perf-stat.i.metric.K/sec
  17316843            +4.0%   18014455        perf-stat.i.minor-faults
  17316843            +4.0%   18014455        perf-stat.i.page-faults
      0.25 ± 70%      +0.2        0.44        perf-stat.overall.branch-miss-rate%
     48.64 ± 70%     +26.0       74.62        perf-stat.overall.cache-miss-rate%
      0.31 ± 70%     +58.4%       0.49        perf-stat.overall.ipc
   1639463 ± 70%     +51.8%    2489322        perf-stat.overall.path-length
   1.8e+10 ± 70%     +58.0%  2.843e+10        perf-stat.ps.branch-instructions
  67385653 ± 70%     +85.0%  1.247e+08        perf-stat.ps.branch-misses
 8.864e+10 ± 70%     +57.8%  1.399e+11        perf-stat.ps.instructions
  11506203 ± 70%     +56.0%   17954441        perf-stat.ps.minor-faults
  11506204 ± 70%     +56.0%   17954441        perf-stat.ps.page-faults
 2.683e+13 ± 70%     +57.9%  4.236e+13        perf-stat.total.instructions
     53.56            -1.1       52.41        perf-profile.calltrace.cycles-pp.testcase
      2.10            -0.5        1.61        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      5.44            -0.1        5.34        perf-profile.calltrace.cycles-pp.error_entry.__madvise
      1.72            -0.1        1.66        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.53            +0.0        0.56        perf-profile.calltrace.cycles-pp.do_shared_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.70            +0.0        1.74        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.62            +0.0        0.66        perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.52            +0.0        0.57        perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.38            +0.1        1.43        perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.68            +0.1        0.74        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.madvise_do_behavior.do_madvise.__x64_sys_madvise
      0.70            +0.1        0.76        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.79            +0.1        1.88        perf-profile.calltrace.cycles-pp.find_vma_prev.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.51            +0.1        0.60        perf-profile.calltrace.cycles-pp.madvise_lock.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            +0.1        0.94        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      1.98            +0.1        2.10        perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages.do_read_fault.do_pte_missing
      0.72            +0.1        0.84        perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.29            +0.1        5.42        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range
      0.42 ± 44%      +0.1        0.56        perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.24 ±  3%      +0.2        1.39        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.testcase
      0.59            +0.2        0.74        perf-profile.calltrace.cycles-pp.xas_load.xas_find.next_uptodate_folio.filemap_map_pages.do_read_fault
      0.85            +0.2        1.04        perf-profile.calltrace.cycles-pp.xas_find.next_uptodate_folio.filemap_map_pages.do_read_fault.do_pte_missing
      1.40            +0.2        1.62        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      6.08            +0.2        6.32        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      2.46            +0.3        2.72        perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault
      5.13            +0.3        5.43        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__madvise
      3.65            +0.3        3.99        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__madvise
     19.78            +0.4       20.16        perf-profile.calltrace.cycles-pp.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.02            +0.4       13.42        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior
     13.60            +0.4       14.01        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior
     14.59            +0.4       15.02        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior.do_madvise
     16.59            +0.5       17.05        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      2.58            +0.5        3.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.testcase
     15.85            +0.5       16.32        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise
     20.68            +0.5       21.18        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      9.88            +0.5       10.38        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault
     20.80            +0.5       21.31        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     45.58            +0.6       46.16        perf-profile.calltrace.cycles-pp.__madvise
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault
      9.17            +0.6        9.75        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      0.74 ±  2%      +0.7        1.43        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.__munmap
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74            +0.7        3.44        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      2.69            +0.7        3.44        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      2.69            +0.7        3.44        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      2.69            +0.7        3.44        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      2.68            +0.7        3.42        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
     21.76            +0.8       22.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.98            +1.0        1.99        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range.zap_pmd_range
      0.00            +1.1        1.14        perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.12            +1.2        2.28        perf-profile.calltrace.cycles-pp.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
     20.54            +1.2       21.77        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
     20.78            +1.3       22.04        perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     21.51            +1.3       22.84        perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     23.06            +1.4       24.46        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     24.98            +1.6       26.53        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     28.08            +1.8       29.90        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     28.35            +1.8       30.20        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     30.84            +1.9       32.72        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     55.96            -1.2       54.78        perf-profile.children.cycles-pp.testcase
      1.26 ±  3%      -0.5        0.79        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      3.87            -0.4        3.42        perf-profile.children.cycles-pp.zap_present_ptes
      2.23            -0.1        2.13        perf-profile.children.cycles-pp.sync_regs
      0.65            -0.1        0.59 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.61 ±  2%      -0.1        0.55 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.29            -0.0        0.26        perf-profile.children.cycles-pp.__blk_flush_plug
      0.48            -0.0        0.46        perf-profile.children.cycles-pp.blk_finish_plug
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.19 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.file_update_time
      0.10 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.mm_needs_global_asid
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.filemap_get_entry
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.free_swap_cache
      0.13 ±  2%      +0.0        0.15        perf-profile.children.cycles-pp.shmem_fault
      0.19            +0.0        0.21        perf-profile.children.cycles-pp.__do_fault
      0.21 ±  2%      +0.0        0.24        perf-profile.children.cycles-pp.unmap_single_vma
      0.52            +0.0        0.54        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.24 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp.mas_prev
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.access_error
      0.31            +0.0        0.34        perf-profile.children.cycles-pp.pte_offset_map_rw_nolock
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.finish_fault
      0.43            +0.0        0.46        perf-profile.children.cycles-pp.___pte_offset_map
      4.74            +0.0        4.77        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.45            +0.0        0.48        perf-profile.children.cycles-pp._raw_spin_lock
      0.53            +0.0        0.57        perf-profile.children.cycles-pp.do_shared_fault
      0.19            +0.0        0.23        perf-profile.children.cycles-pp.xas_start
      0.05            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.folio_mapping
      0.50            +0.0        0.54        perf-profile.children.cycles-pp.folios_put_refs
      0.53            +0.0        0.58        perf-profile.children.cycles-pp.handle_pte_fault
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.madvise_unlock
      0.22 ±  2%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp._find_next_bit
      0.96            +0.1        1.05        perf-profile.children.cycles-pp.___perf_sw_event
      1.83            +0.1        1.92        perf-profile.children.cycles-pp.find_vma_prev
      0.42            +0.1        0.51        perf-profile.children.cycles-pp.down_read
      0.53            +0.1        0.63        perf-profile.children.cycles-pp.madvise_lock
      0.72            +0.1        0.82        perf-profile.children.cycles-pp.__cond_resched
      2.89            +0.1        2.99 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.33            +0.1        1.44        perf-profile.children.cycles-pp.__perf_sw_event
      0.26            +0.1        0.37        perf-profile.children.cycles-pp.folio_mark_dirty
      1.90            +0.1        2.01        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      1.12            +0.1        1.23        perf-profile.children.cycles-pp.__pte_offset_map_lock
      2.27            +0.1        2.39        perf-profile.children.cycles-pp.native_irq_return_iret
      2.05            +0.1        2.18        perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      1.21            +0.1        1.34        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      5.32            +0.1        5.46        perf-profile.children.cycles-pp.flush_tlb_func
      0.64            +0.2        0.80        perf-profile.children.cycles-pp.xas_load
      1.42            +0.2        1.60        perf-profile.children.cycles-pp.mas_walk
      0.88            +0.2        1.08        perf-profile.children.cycles-pp.xas_find
      1.42            +0.2        1.63        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.24 ±  2%      +0.2        0.46        perf-profile.children.cycles-pp.noop_dirty_folio
      6.12            +0.3        6.38        perf-profile.children.cycles-pp.flush_tlb_mm_range
      5.18            +0.3        5.48        perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.56            +0.3        2.86        perf-profile.children.cycles-pp.set_pte_range
      3.93            +0.4        4.28        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     19.81            +0.4       20.20        perf-profile.children.cycles-pp.madvise_do_behavior
     15.88            +0.5       16.34        perf-profile.children.cycles-pp.zap_page_range_single
     16.64            +0.5       17.11        perf-profile.children.cycles-pp.madvise_vma_behavior
     20.73            +0.5       21.23        perf-profile.children.cycles-pp.do_madvise
     20.82            +0.5       21.32        perf-profile.children.cycles-pp.__x64_sys_madvise
      9.99            +0.5       10.50        perf-profile.children.cycles-pp.next_uptodate_folio
      9.19            +0.6        9.76        perf-profile.children.cycles-pp.__irqentry_text_end
     45.91            +0.6       46.50        perf-profile.children.cycles-pp.__madvise
      3.01            +0.6        3.65        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.74            +0.7        3.44        perf-profile.children.cycles-pp.__munmap
      2.74            +0.7        3.44        perf-profile.children.cycles-pp.__vm_munmap
      2.74            +0.7        3.44        perf-profile.children.cycles-pp.__x64_sys_munmap
      2.74            +0.7        3.44        perf-profile.children.cycles-pp.do_vmi_align_munmap
      2.74            +0.7        3.44        perf-profile.children.cycles-pp.do_vmi_munmap
      2.74            +0.7        3.44        perf-profile.children.cycles-pp.vms_clear_ptes
      2.74            +0.7        3.44        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      2.70            +0.7        3.44        perf-profile.children.cycles-pp.unmap_vmas
     28.36            +0.7       29.10        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     15.79            +1.1       16.92        perf-profile.children.cycles-pp.zap_pte_range
     16.34            +1.2       17.50        perf-profile.children.cycles-pp.zap_pmd_range
     17.34            +1.2       18.51        perf-profile.children.cycles-pp.unmap_page_range
      1.13            +1.2        2.30        perf-profile.children.cycles-pp.tlb_flush_rmap_batch
      1.40            +1.2        2.59        perf-profile.children.cycles-pp.tlb_flush_rmaps
     20.58            +1.2       21.81        perf-profile.children.cycles-pp.filemap_map_pages
     20.80            +1.3       22.06        perf-profile.children.cycles-pp.do_read_fault
     21.52            +1.3       22.85        perf-profile.children.cycles-pp.do_pte_missing
     23.09            +1.4       24.49        perf-profile.children.cycles-pp.__handle_mm_fault
     24.58            +1.5       26.08        perf-profile.children.cycles-pp.do_syscall_64
     25.01            +1.6       26.56        perf-profile.children.cycles-pp.handle_mm_fault
     28.15            +1.8       29.98        perf-profile.children.cycles-pp.do_user_addr_fault
     36.24            +1.8       38.08        perf-profile.children.cycles-pp.asm_exc_page_fault
     28.40            +1.8       30.24        perf-profile.children.cycles-pp.exc_page_fault
      9.62            -3.8        5.81        perf-profile.self.cycles-pp.testcase
      3.82            -0.7        3.07        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.83 ±  5%      -0.6        0.19 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.54            -0.2        0.38        perf-profile.self.cycles-pp.__tlb_batch_free_encoded_pages
      0.78            -0.1        0.64        perf-profile.self.cycles-pp.madvise_do_behavior
      2.22            -0.1        2.12        perf-profile.self.cycles-pp.sync_regs
      0.23 ±  2%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.tlb_flush_mmu
      0.19 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.24 ±  2%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.__blk_flush_plug
      0.51            -0.0        0.49        perf-profile.self.cycles-pp.mas_prev_slot
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.free_swap_cache
      0.16            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.pte_offset_map_rw_nolock
      0.16 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.vm_normal_page
      0.42            +0.0        0.44        perf-profile.self.cycles-pp.find_vma_prev
      0.14 ±  2%      +0.0        0.16        perf-profile.self.cycles-pp.unmap_single_vma
      0.17 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.mas_prev
      0.09 ±  5%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.madvise_lock
      0.17            +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.access_error
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.do_pte_missing
      0.50            +0.0        0.52        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.28 ±  3%      +0.0        0.31        perf-profile.self.cycles-pp.down_read
      0.22            +0.0        0.25        perf-profile.self.cycles-pp.do_read_fault
      0.41            +0.0        0.44        perf-profile.self.cycles-pp.___pte_offset_map
      4.73            +0.0        4.76        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.51            +0.0        0.54        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.43            +0.0        0.46        perf-profile.self.cycles-pp._raw_spin_lock
      0.18 ±  2%      +0.0        0.22        perf-profile.self.cycles-pp.xas_start
      0.49            +0.0        0.52        perf-profile.self.cycles-pp.folios_put_refs
      0.41            +0.0        0.45 ±  2%  perf-profile.self.cycles-pp.__madvise
      0.28 ±  2%      +0.0        0.32        perf-profile.self.cycles-pp.xas_find
      0.25            +0.0        0.29        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.19 ±  2%      +0.1        0.25        perf-profile.self.cycles-pp._find_next_bit
      0.01 ±223%      +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.folio_mapping
      0.57            +0.1        0.64        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.42            +0.1        0.48        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.91            +0.1        0.98        perf-profile.self.cycles-pp.handle_mm_fault
      0.79            +0.1        0.86        perf-profile.self.cycles-pp.___perf_sw_event
      0.22 ±  3%      +0.1        0.29        perf-profile.self.cycles-pp.folio_mark_dirty
      0.48            +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      1.48            +0.1        1.56        perf-profile.self.cycles-pp.zap_pte_range
      0.50            +0.1        0.58        perf-profile.self.cycles-pp.flush_tlb_func
      0.54            +0.1        0.62 ±  2%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.65            +0.1        0.74        perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.66            +0.1        0.75        perf-profile.self.cycles-pp.lock_vma_under_rcu
      2.26            +0.1        2.39        perf-profile.self.cycles-pp.native_irq_return_iret
      0.42 ±  2%      +0.1        0.56        perf-profile.self.cycles-pp.xas_load
      1.97            +0.1        2.10        perf-profile.self.cycles-pp.zap_present_ptes
      0.14 ±  4%      +0.2        0.30 ±  2%  perf-profile.self.cycles-pp.tlb_flush_rmap_batch
      1.40            +0.2        1.58        perf-profile.self.cycles-pp.mas_walk
      0.51            +0.2        0.69 ±  2%  perf-profile.self.cycles-pp.set_pte_range
      0.22 ±  2%      +0.2        0.43        perf-profile.self.cycles-pp.noop_dirty_folio
      0.46            +0.3        0.74        perf-profile.self.cycles-pp.do_syscall_64
      5.17            +0.3        5.47        perf-profile.self.cycles-pp.syscall_return_via_sysret
      9.06            +0.3        9.37        perf-profile.self.cycles-pp.next_uptodate_folio
      3.89            +0.4        4.24        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      7.31            +0.4        7.67        perf-profile.self.cycles-pp.filemap_map_pages
      9.18            +0.6        9.76        perf-profile.self.cycles-pp.__irqentry_text_end
      2.75            +0.6        3.37        perf-profile.self.cycles-pp.entry_SYSCALL_64




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

