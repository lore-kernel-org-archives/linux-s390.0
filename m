Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B21F3B9E;
	Mon, 21 Jul 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086621; cv=fail; b=gyK5e4Wo7+tOnTz62NTY9UKODtIOS7uRqKWx+cNCEhwRvB6hv52IVhjuY9SHKyWAUpPaUn6+eYJILs/uA/kUXUDwV426LbaowNPYTID+BTIf6dEw/RtaH/GXZSkdQJZW91n6pG3baqF06zCoRQXhpEJLMdpY6m25HZCoJYZ8Qy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086621; c=relaxed/simple;
	bh=hHhpw/ozD4L+RoQYq0pMFOMFaUIgXk4T8ml73aN478M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cD88czKbcj2kp1Y5oWZS5dx9OD8HwQhBEmeKs2BGA+Vy11P2Cy6hJXax4EQDjwDNhc8udmYPlDFCoJZkJQiqp9E2kqLxsBFQyjJ8+7+ybj2iBu5B5ORi8tQMGKIrgL7N46PK0dK0KJ1gj5ikbc/htcbE4MrdsR+DUUWncmim2QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijEQZlYX; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijEQZlYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753086619; x=1784622619;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=hHhpw/ozD4L+RoQYq0pMFOMFaUIgXk4T8ml73aN478M=;
  b=ijEQZlYXDo0+DiWWkQ9Uc9ZQOCmoW4c/aeC0rkZuSukWKXkKF8hMHE49
   ciEZjgwX1uSUrzHNZpIcaFiodTRyly3QANUNJlnrpdGvggz+bCnP7pJ45
   lq2DwfSQ11SaDGjSHYOiTRv0jhfSTIeLr7bNjjTU44vFG3ZY5941HXssW
   LJQDaT8KSbWWtY54ANEnEjt44LdWmaWBcvl2xYeLd5IV5mDm5M6TuIMUn
   t5Cwr9L45L8cwWZ45tre3viJCQ3CFKAnUkRmMpKmcAyfGfoCrlSjdz1QQ
   6m+9yrbL881RZ+E/6Y8eAx/eceJH8uAVSn80f7uVU79hcjX0XGoSaQ9R1
   w==;
X-CSE-ConnectionGUID: ARUEDkNbSHKOH9hBYtpwOw==
X-CSE-MsgGUID: 5eo0VLbxS9OsQgCJDJqbSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="80739620"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="80739620"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:30:18 -0700
X-CSE-ConnectionGUID: 0/LahGC9Rai6itAQrcQN6w==
X-CSE-MsgGUID: hDmQXBnUSh+cb9V7Kez4lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="189757020"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:30:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 01:30:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 01:30:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 01:30:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCZ/zywET8Aye7VYEiDdUEgQkLMVpvfcxnmu+Xtc24/6Gy24t+aD+ZHq/LIY2gcpKBMPneLx/RLR6BuKTNzOaMroR93O/KOlmoJsNf7WlDTXDmUer6hyJXd2Aj8/dR50U/TyceJMavGjNL5Uy649g16Yfk6NgURM89IpJO7+GJWGRvNo7mOGHeGa3N3W5hbQZbB8Cq5NcdZARBzIUKFpobu09162UB8o13yLp6OzSy83lqeO4Ki/MYy+XRwcTPl1hVeSGBItz0eopHsbhUr3YJGFLFQ8G6MVHrX1YOBOOa9GJ1NXNTHofOnt/7qQfO8QOrNkJ5z8eKjY1weI2syHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3g1LEOTdMYKJkJhShsu9KYOJrqUSfy+Xk7ccTcu9p8=;
 b=l4hs9iz95NG8NWNb+Jfid+shtvDWx017O3wwKzHqrxBdmx/IvC7pvDeh82LfLSZad/MDnvUKsmRC5sOOXyEMzpP0MS7dLSLNd8V37mGSqfS4MPSxHkZCF2KUwGvcY5t2E0MBoyjzaxHnwDfv4jeKTe+T25LsPpFMIdrsLzlPU5A86epf4kGHt6cws93PzNXMGImB5xYixHECKFGjjoxU6PFBa884RvsJau5BEk26MXXai616oVWOkZxULRUy6RqYzRlk6hlt1ZxOA9AnpYy+hqj0gie0pdp1qtQ+g3Bv6GvoZElwH5hS+7ggp1McQ6TpvAp6JKVBqkncA+QZVJFE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8340.namprd11.prod.outlook.com (2603:10b6:303:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:30:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Mon, 21 Jul 2025
 08:30:09 +0000
Date: Mon, 21 Jul 2025 16:29:57 +0800
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
Subject: [linus:master] [mm]  4e92030c05:  will-it-scale.per_process_ops
 10.0% improvement
Message-ID: <202507211016.b016447d-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d6847f-e58e-4dac-9e80-08ddc830cda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?VtrUhmyt+EQZa213w8N2zf+yBs+oKtyM6Ot/Q6t8EZCpekbtjeT+dng67d?=
 =?iso-8859-1?Q?tMcnxA8uSYHG4gVIpaoJiuolquwYKV68hZpoB82oYu4ZFh+P3IUU/sI0Wk?=
 =?iso-8859-1?Q?LoZmBJWzpo1LYYss+kduvdxWec7TlmKTY6/5C+i8YIhqeFTcevWllHCiM1?=
 =?iso-8859-1?Q?LsCV3I14doqO2zDet75K01lfgapyw4Uw6SKQrsOMI1utxhVHvFTzwKNr/n?=
 =?iso-8859-1?Q?wBz+kesan90o6fv/8kRAxh84+PUZlgZaHxxTEhfl4e9mRiHJBZoiTBLJay?=
 =?iso-8859-1?Q?HXJMtwvWBJvcVpjkCqvF1NhxiLkNXRLdJ2r4aCjizIjFTBx47lUeLNbgCN?=
 =?iso-8859-1?Q?Rm3JpTYpuAne4cULl/KghKB+CSDXF6YBrNlbhO8vA1UBD8yud9X6SXFB7I?=
 =?iso-8859-1?Q?VsWDAxnysDuqWslnRvLl37VtojDmnYpYa3j8YctCTU6ZExzBcAIC8IZ43L?=
 =?iso-8859-1?Q?Uk5MHEwBlPSSQXOgb9fh3DwM10FZt4df+jcYRK79mmD/Rf2NNE6i0O4Qm1?=
 =?iso-8859-1?Q?2yzbG7w5EChLFT22ux1kTJLF4gP92VCKrpSDI4iaEtJpwUR1nYd8eoAJfw?=
 =?iso-8859-1?Q?LCkmmasnTvfmnXq/2/C2uqFy+w6NH9Qsg1tD/aL+AjSDhEJYBg4taCv2T3?=
 =?iso-8859-1?Q?m711qDZXB6Jp+FCsAJmnMfaOIuojmUuUEaGwa8j9U0He/Bl4Zw45ERLrg/?=
 =?iso-8859-1?Q?TFc/O6xIYDrWLZ/QqUK1Te752/xJ/u8UtRnSiZ8lHhOu8aFUD25hYe8+p7?=
 =?iso-8859-1?Q?ArcQtaflxDsyPBA02r5xW8gc0VZhaO2mEcpwwOLdRq/oea3d0ArGkhdotM?=
 =?iso-8859-1?Q?B/X+voizAr69ttkw5cOXMwXOu+dNJdvXWYfrzmP+7ClVHGwQ8sNyRRQJdm?=
 =?iso-8859-1?Q?y/PqQoSzkBbTzaawbHWgxYfGmM/5dyrqjc3WQ8NynsQ9YT2+RFoN2rVw94?=
 =?iso-8859-1?Q?boaWQPqvqmjFQXwKQySOLirArYnghrPVYPG2k3WDVRQ9Br7rF+OMLkdP8r?=
 =?iso-8859-1?Q?5tlb3k5Xga1HEM3sp9mmfsjxvMnJ066PyAzuh0S2PuwvHQNdtJ2Ub1XuUa?=
 =?iso-8859-1?Q?ecHIodgDaRj3V96H3oSwuo8GEcRJdFaHW44trifqMzFjY2OcROAZD9XN94?=
 =?iso-8859-1?Q?XG1tdOrI6l7eFrM6zI5DjYsqG7rVtnz2iPqjEnXVV82zG+7DZyNUYAl6Im?=
 =?iso-8859-1?Q?7F3ySP4Yvv/Zx8PMGOxpYlcLn7t5K2rcCM15fiTbXyZ45Om6CpK3x+EsTP?=
 =?iso-8859-1?Q?J2MzeoqjHnpVcI0A/E77SLEj2HsPYGWaFFbWduUZ4/rg7Z6Y5hBX0U798s?=
 =?iso-8859-1?Q?KfezXog1nBozN0zpdzegvZQP39HBMXhcEORsxbIHqDV4OA1WFhC288ojVL?=
 =?iso-8859-1?Q?cFE7lubqKQYYlKpGiWVHK3LUfwdLqd/cfoTA6/cS4tkI37HaP8tFkivvC0?=
 =?iso-8859-1?Q?+XaQFx3eQnbYsNe3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SVBJ82ymEtyCGMGt75p49YQwzF2XV1Hab+Ldkz52n6xW5cWs2HceRh6i+g?=
 =?iso-8859-1?Q?maOHzqX6gnrVnoW1C4Y5vRQH94HXuCYHMZDKrPGvmAZFcX6rzX765boFkx?=
 =?iso-8859-1?Q?OSfzsBiAT0feMUGacnwiBZ+g5gn5L+iQ/DoC6AXnACww6vHGe3IfV+U6UF?=
 =?iso-8859-1?Q?wXM0SgiuwD2W1Pb9vnHBuru4/oEUvkkXjZ2XFB/pNPVNDnLylJ9ah9QW4q?=
 =?iso-8859-1?Q?CSMBU/g9036tRvWtNajXxozS3IWPtbTXOxFgVmdaFCJIMWiroVllbxGNuz?=
 =?iso-8859-1?Q?O2Gkf38T6V/2QVI7CAQyVXsJhTfbsB98GQVvft95xeQv/yZFwEy9QqEgpr?=
 =?iso-8859-1?Q?Vva5qYnCEISLSj3eVrUFI4JVFaD5st/s22DvSdcHdnp029csjP4CiQFFol?=
 =?iso-8859-1?Q?sD00cJIgD4amnFmXA6sIGecGyu8DNp/5GQQqufuSfFIIalgQCByho/jOy4?=
 =?iso-8859-1?Q?N1aTFn+Kz2ZeJifUjf78s1IA330DIx5+DoT40wSMC7aIZZccIKdAmDpQm9?=
 =?iso-8859-1?Q?ITEYOpUur3+3dwuEibiGAqR4/JHeB/x1B9Qku4us2iKXCelvffy2C6Mmf8?=
 =?iso-8859-1?Q?ACZZN+zhXRRK/OmIExALxfXAeCg4LzScsf+O/G7AxzVqT9sWOXz1gS6W9K?=
 =?iso-8859-1?Q?weaFsJccoHvSuzZr6N5OZYPcVvL2afs07rs/JXyNcpxSg+KSNBtn1uTlBI?=
 =?iso-8859-1?Q?PzH8ySQXIdYIU1AN/v+N29ODw0sl/EYDb5DH8zmcgj6Wr1nnjQ9PgDz3GH?=
 =?iso-8859-1?Q?YEmeO37lEe/rsdQCXadBaGJTks0enM8rttsSdOh+dDdhgrDEM+/R/OE0dE?=
 =?iso-8859-1?Q?5Bm6uubON93YacnpBkL5hS/Z1zpdUtNj3g3VIEp/njo0C6LiWG61PeeB80?=
 =?iso-8859-1?Q?9oQnk0Y37QqkLP1GMGlrRDb7B31WbsBSjlrouMoUhnGvzBz96GQ5nlRFyY?=
 =?iso-8859-1?Q?jtCscB6rcIwBmVAjgID9RJQN99laJX07LR9YyeIfSseuVDVLxUp58JEJEU?=
 =?iso-8859-1?Q?xMBeH0tYOoghrbvPTXC+96yb2ZG8n0l5NpeU0usS+sdb6A6PN823wk2bcv?=
 =?iso-8859-1?Q?dgZ6HQfQM4I0el6uPrIayKIK+pJuU2M55iQw0UNaqn89sR/z57rnpn+a4I?=
 =?iso-8859-1?Q?8ejA8hKG3MHl7mzDa4NDl9dGcYn0wdx6dHEmDXj9gSxJ1Qz7NejdBFLe04?=
 =?iso-8859-1?Q?XxAGPHw8RI9ULLE9QMhU88Od/OkCJyzCKZt76DQsHFqiGHVdyozJoHKUUr?=
 =?iso-8859-1?Q?Z/cP9uRkaTBH1vtTkJpGIHlcFY9kbDZ4VqKjGcxNbn7EX4tsLN6hdzjmsr?=
 =?iso-8859-1?Q?dBhloZKNM65NfohCV04yJQa9wuT9Wqb/bNOmBnOjMoTqMRJRoXUTw4vsCe?=
 =?iso-8859-1?Q?caBIED+M3Fdn7cTyJF3QAQ22GjGnZcJNnNMlXUrggkMxhRqUNEUoVMijbM?=
 =?iso-8859-1?Q?cAdbyEME2McyZd1PJYxkI4SHHAL48dq9q/aEBtnFE7LA78I1VSsNXmTgbJ?=
 =?iso-8859-1?Q?4NWlXTM4PTZSHvPxjLkRQB+eBunA8lnYYALf9wL36qU5XL/MOLGKJS7zkd?=
 =?iso-8859-1?Q?a1njUw5fZ2q65gj7TRoaHlr2HC9DLNIQDApmWm0L0IFLvwhAJcYRM0ojIW?=
 =?iso-8859-1?Q?IlTlS5mJNrjJPrtKVlQC23IG+fJbpreKPwPfgCsCxHSJ0hDO6A36n+rQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d6847f-e58e-4dac-9e80-08ddc830cda2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:30:09.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4MZXAkjq5Emf2eq3xO2sZ5BkC8ETzmF69HEnu2zUTokXg2USSvDRqCIe6xt3oaTcvS9E+4u4LrMP5z+mKEr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8340
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 10.0% improvement of will-it-scale.per_process_ops on:


commit: 4e92030c05dc351e62955ac1aba7233157f49b78 ("mm: set the pte dirty if the folio is already dirty")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory
parameters:

	nr_task: 100%
	mode: process
	test: tlb_flush3
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250721/202507211016.b016447d-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp3/tlb_flush3/will-it-scale

commit: 
  f83f362d40 ("mm: fix ratelimit_pages update error in dirty_ratio_handler()")
  4e92030c05 ("mm: set the pte dirty if the folio is already dirty")

f83f362d40ccceb6 4e92030c05dc351e62955ac1aba 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     88293           +43.0%     126221        meminfo.PageTables
     64.62 ± 11%     +13.9%      73.61 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     18.79           -47.7%       9.82        vmstat.cpu.us
     42635           +43.4%      61142        numa-meminfo.node0.PageTables
     45705           +41.4%      64628        numa-meminfo.node1.PageTables
      0.04            +0.0        0.05        mpstat.cpu.all.soft%
     79.47            +9.1       88.54        mpstat.cpu.all.sys%
     18.94            -9.2        9.74        mpstat.cpu.all.usr%
  61913926           +10.0%   68099132        will-it-scale.192.processes
    322468           +10.0%     354682        will-it-scale.per_process_ops
  61913926           +10.0%   68099132        will-it-scale.workload
  27668037           -11.5%   24483826        numa-numastat.node0.local_node
  27792303           -11.4%   24614117        numa-numastat.node0.numa_hit
  27841488           -11.8%   24551255        numa-numastat.node1.local_node
  27917210           -11.8%   24620090        numa-numastat.node1.numa_hit
     10684           +43.4%      15319        numa-vmstat.node0.nr_page_table_pages
  27790899           -11.4%   24613138        numa-vmstat.node0.numa_hit
  27666720           -11.5%   24482847        numa-vmstat.node0.numa_local
     11457           +41.3%      16184        numa-vmstat.node1.nr_page_table_pages
  27915536           -11.8%   24618832        numa-vmstat.node1.numa_hit
  27839814           -11.8%   24550004        numa-vmstat.node1.numa_local
    195921            +0.7%     197220        proc-vmstat.nr_anon_pages
     22141           +42.4%      31530        proc-vmstat.nr_page_table_pages
  55705608           -11.6%   49234172        proc-vmstat.numa_hit
  55505620           -11.7%   49035046        proc-vmstat.numa_local
  55824860           -11.6%   49367562        proc-vmstat.pgalloc_normal
  1.98e+10           +10.0%  2.177e+10        proc-vmstat.pgfault
  49761246            -4.4%   47583096 ±  2%  proc-vmstat.pgfree
      0.30 ±116%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      1.65 ±  3%     +22.2%       2.02 ±  3%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.42 ± 11%     +37.5%       0.58 ± 20%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.56 ± 92%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      3.30 ±  3%     +22.2%       4.04 ±  3%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.21 ± 28%     -83.8%       0.03 ±223%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    469.33 ± 18%     +44.8%     679.67 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      1385 ±  3%     -27.1%       1010 ±  5%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    218.83 ± 39%     -89.6%      22.83 ±223%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      6.20 ±  6%     -83.8%       1.00 ±223%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.30 ±116%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      1.65 ±  3%     +22.2%       2.02 ±  3%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.40 ± 14%     +42.9%       0.57 ± 19%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.56 ± 92%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
  1.02e+11           +11.3%  1.136e+11        perf-stat.i.branch-instructions
 1.801e+08           +11.2%  2.004e+08        perf-stat.i.branch-misses
     63.59            +1.3       64.87        perf-stat.i.cache-miss-rate%
   1.6e+08           +10.4%  1.767e+08        perf-stat.i.cache-misses
 2.514e+08            +8.2%  2.721e+08        perf-stat.i.cache-references
      1.11           -10.1%       1.00        perf-stat.i.cpi
    266.28            -4.7%     253.64        perf-stat.i.cpu-migrations
      3465            -9.4%       3138        perf-stat.i.cycles-between-cache-misses
 4.995e+11           +11.2%  5.557e+11        perf-stat.i.instructions
      0.90           +11.2%       1.00        perf-stat.i.ipc
    682.53           +10.0%     750.62        perf-stat.i.metric.K/sec
  65522281           +10.0%   72059074        perf-stat.i.minor-faults
  65522281           +10.0%   72059074        perf-stat.i.page-faults
     63.66            +1.3       64.94        perf-stat.overall.cache-miss-rate%
      1.11           -10.1%       1.00        perf-stat.overall.cpi
      3465            -9.4%       3139        perf-stat.overall.cycles-between-cache-misses
      0.90           +11.2%       1.00        perf-stat.overall.ipc
   2431176            +1.2%    2459607        perf-stat.overall.path-length
 1.017e+11           +11.3%  1.132e+11        perf-stat.ps.branch-instructions
 1.795e+08           +11.2%  1.997e+08        perf-stat.ps.branch-misses
 1.595e+08           +10.4%  1.761e+08        perf-stat.ps.cache-misses
 2.506e+08            +8.2%  2.712e+08        perf-stat.ps.cache-references
    265.31            -4.7%     252.72        perf-stat.ps.cpu-migrations
 4.979e+11           +11.2%  5.539e+11        perf-stat.ps.instructions
  65304628           +10.0%   71819878        perf-stat.ps.minor-faults
  65304629           +10.0%   71819879        perf-stat.ps.page-faults
 1.505e+14           +11.3%  1.675e+14        perf-stat.total.instructions
     66.74            -3.3       63.43        perf-profile.calltrace.cycles-pp.testcase
      4.50            -1.2        3.32        perf-profile.calltrace.cycles-pp.down_read.madvise_lock.do_madvise.__x64_sys_madvise.do_syscall_64
      4.60            -1.2        3.43        perf-profile.calltrace.cycles-pp.madvise_lock.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.67            -0.6        1.04        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.57            +0.1        0.63        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.78            +0.1        0.86        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.51            +0.1        0.60        perf-profile.calltrace.cycles-pp.do_shared_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.82            +0.1        0.91        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      0.67            +0.1        0.77        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault
      0.55            +0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.xas_load.xas_find.next_uptodate_folio.filemap_map_pages.do_read_fault
      1.25            +0.1        1.38        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.62            +0.1        0.77        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.97            +0.2        1.16        perf-profile.calltrace.cycles-pp.xas_find.next_uptodate_folio.filemap_map_pages.do_read_fault.do_pte_missing
      0.83            +0.2        1.02        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.madvise_do_behavior.do_madvise.__x64_sys_madvise
      1.31            +0.2        1.52        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.76 ±  2%      +0.2        0.97        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages
      2.00            +0.2        2.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.testcase
      0.96            +0.2        1.20        perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.43 ± 44%      +0.3        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.tlb_flush_rmap_batch.tlb_flush_rmaps
      1.86            +0.3        2.13        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.22            +0.3        1.54        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages.do_read_fault
      1.88            +0.4        2.24        perf-profile.calltrace.cycles-pp.find_vma_prev.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      1.97            +0.4        2.35        perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages.do_read_fault.do_pte_missing
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.__munmap
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      2.38            +0.4        2.81        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      2.85            +0.4        3.30        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.zap_pte_range.zap_pmd_range
      2.30            +0.5        2.79        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      2.32            +0.5        2.80        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      2.32            +0.5        2.80        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      2.32            +0.5        2.80        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      0.00            +0.5        0.50        perf-profile.calltrace.cycles-pp.tlb_gather_mmu.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior.do_madvise
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.40            +0.5        3.91        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      4.49            +0.5        5.02        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      1.82            +0.6        2.38        perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.mas_prev_slot.find_vma_prev.madvise_do_behavior.do_madvise.__x64_sys_madvise
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.09            +0.6        1.71        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
      2.43            +0.6        3.06        perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault
      4.48            +0.7        5.15        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.78            +0.8        1.60        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range
      0.00            +1.0        1.00        perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.54            +1.4        2.98        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range.zap_pmd_range
      1.69            +1.5        3.22        perf-profile.calltrace.cycles-pp.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
     22.93            +1.7       24.60        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     23.03            +1.7       24.71        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     23.99            +1.8       25.77        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     16.14            +1.8       17.94        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault
     24.19            +1.8       26.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     11.00            +1.9       12.87        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior
     11.60            +2.0       13.55        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior
     12.61            +2.1       14.72        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior.do_madvise
     14.18            +2.3       16.44        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise
     14.90            +2.3       17.23        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     18.56            +2.5       21.03        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__madvise
     17.69            +2.8       20.47        perf-profile.calltrace.cycles-pp.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.60            +3.3       38.90        perf-profile.calltrace.cycles-pp.__madvise
     29.80            +3.4       33.22        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
     30.72            +3.6       34.29        perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     31.42            +3.7       35.10        perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     33.24            +4.0       37.27        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     34.80            +4.4       39.18        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     38.48            +5.0       43.48        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     38.77            +5.1       43.83        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     44.87            +5.8       50.67        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     71.52            -2.5       69.04        perf-profile.children.cycles-pp.testcase
      4.53            -1.2        3.35        perf-profile.children.cycles-pp.down_read
      4.64            -1.2        3.47        perf-profile.children.cycles-pp.madvise_lock
      3.13            -0.4        2.73        perf-profile.children.cycles-pp.zap_present_ptes
      0.50            -0.0        0.47        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.madvise@plt
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.arch_check_zapped_pte
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.reclaim_pt_is_enabled
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.uprobe_munmap
      0.18            +0.0        0.19        perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.22            +0.0        0.23        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09            +0.0        0.10        perf-profile.children.cycles-pp.madvise_dontneed_free_valid_vma
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.madvise_unlock
      0.10            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.15 ±  2%      +0.0        0.16        perf-profile.children.cycles-pp.shmem_fault
      0.07 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      0.06 ±  7%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.50            +0.0        0.52        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.13 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.free_swap_cache
      0.12 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.__irqentry_text_end
      0.11            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.can_modify_vma_madv
      0.20            +0.0        0.22        perf-profile.children.cycles-pp.userfaultfd_remove
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.mm_needs_global_asid
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__cmd_record
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.cmd_record
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.handle_internal_command
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.main
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.run_builtin
      0.06 ±  6%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.perf_mmap__push
      0.09            +0.0        0.11        perf-profile.children.cycles-pp.p4d_offset
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.alloc_pages_noprof
      0.08            +0.0        0.10        perf-profile.children.cycles-pp.mas_prev_setup
      0.24            +0.0        0.26        perf-profile.children.cycles-pp.__blk_flush_plug
      0.12 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.irqentry_enter
      0.06 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.21 ±  2%      +0.0        0.23        perf-profile.children.cycles-pp.vm_normal_page
      0.16            +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.perf_exclude_event
      0.31            +0.0        0.34        perf-profile.children.cycles-pp.blk_finish_plug
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.pte_alloc_one
      0.19            +0.0        0.22        perf-profile.children.cycles-pp.finish_fault
      0.33            +0.0        0.36        perf-profile.children.cycles-pp.up_read
      0.24 ±  7%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.17 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.perf_swevent_event
      0.18 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.folio_mark_accessed
      0.27            +0.0        0.31        perf-profile.children.cycles-pp.unmap_single_vma
      0.22            +0.0        0.26        perf-profile.children.cycles-pp.__do_fault
      0.53            +0.0        0.57        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.39            +0.0        0.43        perf-profile.children.cycles-pp.rcu_all_qs
      0.72            +0.0        0.76        perf-profile.children.cycles-pp._raw_spin_lock
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.44            +0.0        0.49        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.85            +0.1        0.90        perf-profile.children.cycles-pp.folios_put_refs
      0.20 ±  2%      +0.1        0.25        perf-profile.children.cycles-pp.mas_prev
      0.23 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.30            +0.1        0.36        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.23            +0.1        0.29        perf-profile.children.cycles-pp.access_error
      0.34            +0.1        0.40        perf-profile.children.cycles-pp._find_next_bit
      0.59            +0.1        0.66        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.83 ±  5%      +0.1        0.90 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.56            +0.1        0.63        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.52            +0.1        0.60        perf-profile.children.cycles-pp.do_shared_fault
      0.89 ±  5%      +0.1        0.97 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.72            +0.1        0.81        perf-profile.children.cycles-pp.__cond_resched
      0.88 ±  5%      +0.1        0.96 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.50            +0.1        0.59        perf-profile.children.cycles-pp.mas_prev_slot
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.08 ±  4%      +0.1        0.17        perf-profile.children.cycles-pp.folio_mapping
      0.39            +0.1        0.48        perf-profile.children.cycles-pp.pte_offset_map_rw_nolock
      0.55            +0.1        0.64        perf-profile.children.cycles-pp.error_entry
      1.08 ±  5%      +0.1        1.17 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.07 ±  5%      +0.1        1.16 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.16 ±  5%      +0.1        1.26 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.12 ±  5%      +0.1        1.22 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.47            +0.1        0.57        perf-profile.children.cycles-pp.__mod_node_page_state
      0.54            +0.1        0.65        perf-profile.children.cycles-pp.handle_pte_fault
      0.40 ±  2%      +0.1        0.52        perf-profile.children.cycles-pp.__count_memcg_events
      1.20            +0.1        1.31        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.66            +0.1        0.78        perf-profile.children.cycles-pp.___pte_offset_map
      1.34            +0.1        1.46        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.63            +0.1        0.77        perf-profile.children.cycles-pp.xas_load
      1.61            +0.2        1.77        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.17            +0.2        0.34        perf-profile.children.cycles-pp.folio_mark_dirty
      0.88            +0.2        1.06        perf-profile.children.cycles-pp.___perf_sw_event
      1.02            +0.2        1.21        perf-profile.children.cycles-pp.xas_find
      1.61            +0.2        1.82        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.09            +0.2        1.30        perf-profile.children.cycles-pp.__perf_sw_event
      1.70            +0.2        1.93        perf-profile.children.cycles-pp.tlb_flush_mmu
      1.91            +0.3        2.19        perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.94            +0.4        2.31        perf-profile.children.cycles-pp.find_vma_prev
      2.09            +0.4        2.49        perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      2.38            +0.4        2.81        perf-profile.children.cycles-pp.__munmap
      2.38            +0.4        2.81        perf-profile.children.cycles-pp.__vm_munmap
      2.38            +0.4        2.81        perf-profile.children.cycles-pp.__x64_sys_munmap
      2.38            +0.4        2.81        perf-profile.children.cycles-pp.do_vmi_align_munmap
      2.38            +0.4        2.81        perf-profile.children.cycles-pp.do_vmi_munmap
      1.73            +0.4        2.16        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      2.38            +0.4        2.81        perf-profile.children.cycles-pp.vms_clear_ptes
      2.38            +0.4        2.81        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      1.82            +0.4        2.26        perf-profile.children.cycles-pp.mas_walk
      2.87            +0.4        3.31        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      4.85            +0.5        5.32        perf-profile.children.cycles-pp.native_irq_return_iret
      2.32            +0.5        2.80        perf-profile.children.cycles-pp.unmap_vmas
      4.60            +0.5        5.12        perf-profile.children.cycles-pp.sync_regs
      3.47            +0.5        4.00        perf-profile.children.cycles-pp.flush_tlb_func
      2.39            +0.6        3.04        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      2.57            +0.7        3.22        perf-profile.children.cycles-pp.set_pte_range
      2.74            +0.7        3.40        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      4.56            +0.7        5.25        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.73            +1.5        3.28        perf-profile.children.cycles-pp.tlb_flush_rmap_batch
      1.87            +1.6        3.44        perf-profile.children.cycles-pp.tlb_flush_rmaps
     22.98            +1.7       24.66        perf-profile.children.cycles-pp.do_madvise
     23.06            +1.7       24.74        perf-profile.children.cycles-pp.__x64_sys_madvise
     16.02            +1.8       17.80        perf-profile.children.cycles-pp.next_uptodate_folio
     26.48            +2.2       28.71        perf-profile.children.cycles-pp.do_syscall_64
     26.66            +2.2       28.90        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.27            +2.3       16.53        perf-profile.children.cycles-pp.zap_page_range_single
     15.00            +2.3       17.35        perf-profile.children.cycles-pp.madvise_vma_behavior
     13.45            +2.4       15.84        perf-profile.children.cycles-pp.zap_pte_range
     13.96            +2.4       16.40        perf-profile.children.cycles-pp.zap_pmd_range
     14.98            +2.6       17.58        perf-profile.children.cycles-pp.unmap_page_range
     17.76            +2.8       20.55        perf-profile.children.cycles-pp.madvise_do_behavior
     36.00            +3.4       39.35        perf-profile.children.cycles-pp.__madvise
     30.47            +3.5       33.97        perf-profile.children.cycles-pp.filemap_map_pages
     30.76            +3.6       34.32        perf-profile.children.cycles-pp.do_read_fault
     31.45            +3.7       35.13        perf-profile.children.cycles-pp.do_pte_missing
     33.29            +4.0       37.33        perf-profile.children.cycles-pp.__handle_mm_fault
     34.89            +4.4       39.28        perf-profile.children.cycles-pp.handle_mm_fault
     38.56            +5.0       43.58        perf-profile.children.cycles-pp.do_user_addr_fault
     38.83            +5.1       43.90        perf-profile.children.cycles-pp.exc_page_fault
     53.93            +7.0       60.94        perf-profile.children.cycles-pp.asm_exc_page_fault
     21.09            -8.7       12.43        perf-profile.self.cycles-pp.testcase
      4.31            -1.2        3.12        perf-profile.self.cycles-pp.down_read
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.reclaim_pt_is_enabled
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.__x64_sys_madvise
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.irqentry_enter
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.madvise_dontneed_free_valid_vma
      0.11            +0.0        0.12        perf-profile.self.cycles-pp.madvise_lock
      0.30            +0.0        0.31        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.19            +0.0        0.20        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.17            +0.0        0.18        perf-profile.self.cycles-pp.userfaultfd_remove
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.flush_tlb_batched_pending
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.can_modify_vma_madv
      0.15 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.16            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.tlb_flush_rmaps
      0.14 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.46            +0.0        0.48        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.43            +0.0        0.44        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.11            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__tlb_batch_free_encoded_pages
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.vm_normal_page
      0.14            +0.0        0.16        perf-profile.self.cycles-pp.tlb_flush_mmu
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.mas_prev_setup
      0.07            +0.0        0.09        perf-profile.self.cycles-pp.p4d_offset
      0.18            +0.0        0.20        perf-profile.self.cycles-pp.__blk_flush_plug
      0.22            +0.0        0.24        perf-profile.self.cycles-pp.do_madvise
      0.15 ±  3%      +0.0        0.17        perf-profile.self.cycles-pp.perf_swevent_event
      0.94            +0.0        0.96        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.11 ±  3%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.perf_exclude_event
      0.28            +0.0        0.31        perf-profile.self.cycles-pp.do_syscall_64
      0.31            +0.0        0.34        perf-profile.self.cycles-pp.up_read
      0.25            +0.0        0.27        perf-profile.self.cycles-pp.rcu_all_qs
      0.46            +0.0        0.48        perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.16 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.handle_pte_fault
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.mas_prev
      0.16            +0.0        0.19        perf-profile.self.cycles-pp.folio_mark_accessed
      0.17 ±  3%      +0.0        0.20        perf-profile.self.cycles-pp.do_pte_missing
      0.16 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.pte_offset_map_rw_nolock
      0.21 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.__perf_sw_event
      0.19            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.exc_page_fault
      0.21            +0.0        0.24        perf-profile.self.cycles-pp.unmap_single_vma
      0.24 ±  8%      +0.0        0.28 ±  3%  perf-profile.self.cycles-pp.update_rq_clock
      0.65            +0.0        0.68        perf-profile.self.cycles-pp._raw_spin_lock
      0.14 ±  2%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.39            +0.0        0.43        perf-profile.self.cycles-pp.__cond_resched
      0.35            +0.0        0.39        perf-profile.self.cycles-pp.zap_page_range_single
      0.43            +0.0        0.47        perf-profile.self.cycles-pp.madvise_do_behavior
      0.40            +0.0        0.45        perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.29            +0.0        0.34        perf-profile.self.cycles-pp._find_next_bit
      0.43            +0.0        0.48        perf-profile.self.cycles-pp.find_vma_prev
      0.38            +0.0        0.42        perf-profile.self.cycles-pp.zap_pmd_range
      0.82            +0.0        0.87        perf-profile.self.cycles-pp.folios_put_refs
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.26            +0.1        0.31        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.23 ±  3%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.40            +0.1        0.46        perf-profile.self.cycles-pp.madvise_vma_behavior
      0.22            +0.1        0.28        perf-profile.self.cycles-pp.access_error
      0.51            +0.1        0.57        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.41            +0.1        0.47        perf-profile.self.cycles-pp.xas_find
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.noop_dirty_folio
      0.39            +0.1        0.45        perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.28            +0.1        0.35        perf-profile.self.cycles-pp.do_read_fault
      0.40            +0.1        0.47        perf-profile.self.cycles-pp.asm_exc_page_fault
      0.55            +0.1        0.62        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.71            +0.1        0.78        perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.54            +0.1        0.62        perf-profile.self.cycles-pp.flush_tlb_func
      0.08 ±  5%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.folio_mark_dirty
      0.07            +0.1        0.15        perf-profile.self.cycles-pp.folio_mapping
      0.16            +0.1        0.24        perf-profile.self.cycles-pp.tlb_flush_rmap_batch
      0.48            +0.1        0.56        perf-profile.self.cycles-pp.mas_prev_slot
      0.50            +0.1        0.58        perf-profile.self.cycles-pp.error_entry
      0.52            +0.1        0.61        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.75            +0.1        0.84        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.40            +0.1        0.49        perf-profile.self.cycles-pp.__mod_node_page_state
      0.46            +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.29 ±  2%      +0.1        0.39        perf-profile.self.cycles-pp.__count_memcg_events
      0.74            +0.1        0.85        perf-profile.self.cycles-pp.do_user_addr_fault
      0.60            +0.1        0.72        perf-profile.self.cycles-pp.___pte_offset_map
      0.58            +0.1        0.70        perf-profile.self.cycles-pp.___perf_sw_event
      1.02            +0.1        1.15        perf-profile.self.cycles-pp.__madvise
      0.62 ±  2%      +0.1        0.74 ±  2%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.88            +0.1        1.02        perf-profile.self.cycles-pp.unmap_page_range
      1.16            +0.2        1.31        perf-profile.self.cycles-pp.zap_pte_range
      1.54            +0.2        1.70        perf-profile.self.cycles-pp.zap_present_ptes
      0.74            +0.2        0.90        perf-profile.self.cycles-pp.handle_mm_fault
      1.23            +0.2        1.45        perf-profile.self.cycles-pp.__handle_mm_fault
      0.45            +0.2        0.69        perf-profile.self.cycles-pp.set_pte_range
      0.99            +0.3        1.31        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      1.30 ±  2%      +0.4        1.70 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.75            +0.4        2.18        perf-profile.self.cycles-pp.mas_walk
      2.83            +0.4        3.27        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      4.85            +0.5        5.32        perf-profile.self.cycles-pp.native_irq_return_iret
      4.58            +0.5        5.09        perf-profile.self.cycles-pp.sync_regs
     11.61            +1.0       12.63        perf-profile.self.cycles-pp.filemap_map_pages
     14.32            +1.5       15.80        perf-profile.self.cycles-pp.next_uptodate_folio




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

