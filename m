Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE245A28E;
	Fri, 14 Aug 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698861; cv=fail; b=HEipxTgyM3EzbCdKCPLD0sbeX3xl/fzfc1RxYrze5cBggdSgeiOwDiZf/B23irQanfl14rO8Y9knjV8rwIAfFXeVkFrBEB/WmwJMIGeqa37klYBJ0YJHe7mwT5Eo3aBzCK3qs099xi60pNu8HT5yXdgrNtAj6uvMSVmR5TtgMWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698861; c=relaxed/simple;
	bh=2AmCxvnPOpmuF6DbaOUC54Y7+rtsLBLMAvpBVcxYa4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l2vairevNeo6PrGg3AQ1dgn4N0Ulbm0SJpGrncdlZm/YymNjWXyynP3OTjdWIOmxwbKQIGX/yJNjkgN4MxH79djBJDz7419RyDYslXp0Fwx5R2/Kz+h0/AELYiHCnF8DzEklOMbOA4R6NcU0WXhmfMvF8pe2BoYct2suo16zaBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ow1PqJb8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ow1PqJb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786698856; x=1818234856;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2AmCxvnPOpmuF6DbaOUC54Y7+rtsLBLMAvpBVcxYa4Q=;
  b=Ow1PqJb897GEs81gdBa1BDLg13jMjnczLETMzwVccXdTbFdOKOspK68U
   37H0vLZFiV/e94UGP1/VmE9+f2NxJ0u9Ho59n3K4CALPxRPfa9h+llyBc
   HSsWOLK4Tm2FuP7CCPlMp6eziNpNakvZE72t1eWDQzwAKjuwJX6qR8toi
   x08XWBluiI8CCuUr/V/KQZopBgJAcFDv6TVjebYeeigOarRk9uBmSYe4z
   zPABLZvkbXRNrf2VNziuiU2dNFtsCtlPYla2/e4/kVUvMwd07R2ICS3y1
   9/AZQ9d3ix1HX/lV4t7AtZoOGiYlJgfys3OKUDCppVks5YSl6uxZP5hvc
   Q==;
X-CSE-ConnectionGUID: CY/5zzWAQnGhMCkJG0hwPg==
X-CSE-MsgGUID: +5hAy/f1R4OME88eId2JoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104810315"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="104810315"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:14:14 -0700
X-CSE-ConnectionGUID: NVo5jHs1S7aBu8dkEaAP6g==
X-CSE-MsgGUID: AyKUf6STQey0vddMWzp9BQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:14:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 02:14:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 02:14:13 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 02:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3HY7RkShOA0F1xaLBmn92jHi7MOv5e7wL8DbJfJwnFu6UBPGhciJHWNfXCh98Tlcz8dENuaWc4maAefYhyrM2onPgxQmMcaElVpH5wkqbnu/9xxI0OQcK105LATFO5sJmatjELiaPj+B9iNl1N3jFwBVYZqoSvY75yru4XVRQcLA2vpqUVz2JpRHAX7mRsdBUW68/Qyrk8jEAT78kimaK1UlTOcLh19HOVOOhEhELR+5+01cBh00bfeh7PmNrqmeY4NdWF6xDkTwOuU9o0CPhbyeoumeoE1o0E1ozYSxN9uS/Uu3N/DmH1W50qlKooovH+tTkvGwGwv7cU/YFibcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCzYyEjhO5DnRTq8NrK2OJVOi+JRDctBy9a7o+yau7k=;
 b=nVBmtm3zss0c7AT3kbkBXONUksTpmzYX2NB6XgjKGIR7JrZNJ1+v0m+Xpv/yM0rSwPGxxaWPUO0yFjDk4kk59anGULNaOe+wr9AVyHx5vq/wW2IsMgekugEWlxDDzOAPPriRP5lbfqWO3U77HZLd3QUZHLMOVzY6q2KTkEVgu2Rvs6INqsdfS2EueYCq+2qriVh7ja3A7nCKeo3jKGzN/Dl04RdWBuxUjpH1QGBgqpAUb1+ylWDyhxvQHsuiI43ZyIpc0TNKkkH8pOiPQD+k+/sDeAjbCrFAP/ZZ+nI2PimrWyOjk02yWOOPq0Fn87/UeaHzxQjYPK1MWEVzTgyzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB6748.namprd11.prod.outlook.com (2603:10b6:510:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 09:13:57 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 09:13:57 +0000
Date: Fri, 14 Aug 2026 02:13:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
	<vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn
	<jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin
	<linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, "Rik van
 Riel" <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Lance Yang
	<lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, "Peter
 Xu" <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
	<chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Boris Brezillon
	<boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld
	<matthew.auld@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, "John
 Hubbard" <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, "Oscar
 Salvador" <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, Kairui Song
	<kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
	<nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park
	<youngjun.park@lge.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<linux-perf-users@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH v5 00/16] mm/rmap: index MAP_PRIVATE file-backed folios
 by anonymous pgoff
Message-ID: <an7cT4KomGatNOB0@gsse-cloud1.jf.intel.com>
References: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
 <20260813115346.2aaad419a351341a4f5f3ae0@linux-foundation.org>
 <an7SkamROquJ7If0@lucifer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an7SkamROquJ7If0@lucifer>
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f346801-4b71-410b-e8ed-08def9e45e8e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|6133799003|56012099006|4143699003|5023799004|22082099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: P9yhYR9Zg1jCh/DzS+6zpwCgnO75gl9puaY5D/sb8k8476IB6i9OokESTZ9F6I9cCLt8R9tOEeVh2kqy8kseVqbdoWGjdBE5IDOi9C8sN3sdHelhlahpTwnMdYTqAPw2tAOhUFJC5jyOfILhsD3DuaNGozUumI6rA8vi6W5Mdb7taigZP110MmzNkDlbnHEkES74sdMuXHejUGyR6nq7/4/0x6134+M/EuWbdCmxOv8FO0JIJSDCC375u3GEJV4ylBENFhFg/tpoZH3kxZZ+5az1N3LLmN5kuOnAV7GO0kmr/yrQVYOgYgtaV7hWEonIUaKD2J1h+Uk9M7LZpzDLD2Ba1aX7rIcoXdF+ZAEMDwBWR0E2prG6BGPb1+bslP3xM7vW/UiPTuO+5PjFLfGkmCVv6Ir3kEcl1Osn+L74ry3+OPz+wx1mZDJF0fx927MDPZhj8seNj/ZNjbPliq+4SC+AwTzzk9U+U3KD/AI6ognBDc6DXcVq/gWgAFh5CDO/ImVOkGnmrZe3Xv9gudVWtoCrGjVu+4PmUlmJW0HA//M1qQER3wt2CDjNp6Hc7w0fo3+CrlLgtfmHcnQcnfbTUh7OFKbwEBmxHmo5ish5ZyDOLAURXIFFSglqMmWa3TzqI/kQz43ZPK+vAXIRKs66yBofUg1mg82jUapUeisc+2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(6133799003)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tV7XiMDl1Hcj9nQMFe/GvQNFjh+IFaKLsWegflRNJPHeCA/+6w3PmG+bcEB9?=
 =?us-ascii?Q?3luAQ3F+aMXmJnOtRtYjs3wsC8Qg+CjTqhWl5FTbiv+HJ9TodIg3p7zheLYO?=
 =?us-ascii?Q?ShiYisY4ySRPD5PIDhNHBkjxCxcdzzGO1PBQ24iXf2HbmZ2UX29dClAWXD8X?=
 =?us-ascii?Q?+e9GDrhgiplEwiYoqxBZE1WSVv90D1K5OnkpzvFMIkJBuBaFy0AIWMufIH7V?=
 =?us-ascii?Q?ajyg4NnBQhNqEQOoOvEfk9W5xSPI8iXHti7Fh2+R3kHFVMAoNVKGHI0I0yh+?=
 =?us-ascii?Q?Vc1VZhNl5vckHELen6XFu2ohbE0+1v0k5zm6YbDFMLv3L/mNiZqGa7Sy4U8c?=
 =?us-ascii?Q?F6pHNy/1+YCZM8MKoanXlntx4G72XkGzTvskfrPbPE6uPd8yj+9RljUfnMOG?=
 =?us-ascii?Q?0U1ysJjggE+dzncmQZRtZeUz3eVZvs28eEK8buq6mDNycz20w5Wl0CjVhPmE?=
 =?us-ascii?Q?HvFLHPeJ2TMm6dtsdpyjIsYTDc4Q/lQAezAh6sISOjxCUWBWa7xIxhfsqys2?=
 =?us-ascii?Q?EwH/3zs9/2901GtST5ANXkrOlxoe5ok7DMnDF/ojUBLZkInMTlOBjNPUy0wS?=
 =?us-ascii?Q?fLXbaDNEz6LMM9fAU1PkWj9Xg2srzhmu/WAtbO+P+wpJLDUwgEK80b0t/x3v?=
 =?us-ascii?Q?Xz+DhY1p42f9u5w2mvd4rYyMvxEFMieRKPKZVMKekZOBqnN1RPoBCxGcFmPu?=
 =?us-ascii?Q?yfYiwvY5gYUz3cOo6rtH8gLrdIVVn5qgGGL1Y4Fo1dsht2S9ymf+h99UUSwG?=
 =?us-ascii?Q?SjfLW6bJJzH5ERwUuzLPmAzdu7kb+Wnqm73wLP5Cu2NhMNhyHDtitw5J6XOr?=
 =?us-ascii?Q?8Tx8qK+RHRUJr2e3EARZYj/G9w7rFd3p1XwfvYw792zZogwSrxMRYeXrfSQf?=
 =?us-ascii?Q?iWfiC1JdVgL5QdGyNQJdsQyEPUzCypzXvwiXldC/93L6VnpIKzN3uf+TKEGX?=
 =?us-ascii?Q?9d9eboc8E7BHHsdTDTG2q1+96z5CFCKcb/jwqhpszXIodGJNhAeEu5BUV+Eq?=
 =?us-ascii?Q?fNchbSP64YMzl5nhiODF0y5y/wVknrDaxK6hcQ0epzwXhY0vRWk25EKj5W3h?=
 =?us-ascii?Q?i+xuAKbk7wWV+FkQoCv4gqF5nMx1xA/Br2psgZsYH+CviPR9QiiWbIZ4cQew?=
 =?us-ascii?Q?lKcngLJ88XL139VOgeo1u3b2VS/sHQpfDycaSGD5W1gx+f2/Gh6oEQ+2plYv?=
 =?us-ascii?Q?Gws7HdyJ/euj1X9gzwE/MsvRR5M+s+N+YEnLNDR19h2cyPJLqscQ1MZ+LAui?=
 =?us-ascii?Q?DLQPtXfgbYBuWx8l+Th2aeyq3D6uxeQJfLdQicaHuMxgUdfpfPZJvnN0Rv8a?=
 =?us-ascii?Q?0RnBVaqlRjCM7/Mcamq2kToMab1lox7a9y0XAHkAbktl21uiUr/Y4dSuhvK+?=
 =?us-ascii?Q?xUTtPtGc0nx4/6Ey0ETFnneCPyfcEEtPWwnI60BaVcKIkO2fLXLzavg+N9QZ?=
 =?us-ascii?Q?6E31fFBcvlceDAxJOwv+bWiCyygiITFDTohxmBNSqcD9wwlvSmIMx/wY1dlG?=
 =?us-ascii?Q?D1gffSJOlGzDPQ1UdBY7plbfKrMtZh376gE3hvrvGERM032nYG29GbOUKABY?=
 =?us-ascii?Q?3zHSPBZvXeJCN7S8PpTxhypPM0Ee5/QLxqdSD08NGxHM2LPAyh6BJmj+1vaF?=
 =?us-ascii?Q?MrVwuDAVMsAAxElpdRrvP7mkV/W4wo8FSQ9fJjdlVaNCXvVPock5ijEFucbX?=
 =?us-ascii?Q?uY3T3ObPNKB8rzkPOIvhu0TtFVb0PQhlcLKtqvxegixYdv1mHjWmj3JXVunu?=
 =?us-ascii?Q?0sVsmDWxFw=3D=3D?=
X-Exchange-RoutingPolicyChecked: FM3Fl+KajXG3MXgjc8+LfRo53ipfOW8s3pP4bQhpyQUDK/PdJbk1G8kn1E56mmCYLc72xgllz7AsHDP6W3pivfbd0tat96FGmKP41oGzJEHpUc9Bm5aXYLgaAhTmqQ5Bs+2O/Y7Gkgyn3jEMe6CIalRhHuoztYIGTVAJNGCfXt3mji4TIJf23X6e3yXKx1QYMI0/3LhWzMU1ceJFs9mPhWBNuvs4mW1JeEGuyNxrm9inq/ourcYJrrewwJgHJ9VLt2LB+x7IrIwwRh6v3ObliePGOfTgGTtkT+OANiv5B0A9xW9eR226Db/r82oQbvzBK6+RS3x4/qcRfo+vqEd6wQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f346801-4b71-410b-e8ed-08def9e45e8e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:13:57.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YECZGdWyQJ7YmDsccMjelS3Ajy6X8BH14+50iEVL07DhkT8DxQRD1Dort7Rt9e3aNZKKSWfKgU6lWR3V7wCqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6748
X-OriginatorOrg: intel.com

On Fri, Aug 14, 2026 at 10:01:19AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Aug 13, 2026 at 11:53:46AM -0700, Andrew Morton wrote:
> > You'll be mortified to hear that Sashiko wasn't able to find anything
> > to which to apply this.
> 
> :))
> 
> Well, when it's right it's useful, when it's wrong or suggesting unrelated
> what-nots it's less useful :>)
> 

Questioning your assumptions is useful, even when they turn out to be wrong.
Show more lines

> I do locally put things through claude + Chris Mason's prompts a lot, I
> don't always invoke local sashiko as it's very slow and token-heavy or has
> been so far, but am planning to do that more also in future.
> 

Yes, it's kind of odd that Sashiko burns more tokens than a full day of
breakfast, lunch, and dinner service. Running Sashiko is a bottleneck in
my workflow, so I'll defer to others on this list.

> >
> > Sashiko can be guided with a base-commit: tag but I'm not sure how to
> > tell it what tree/branch to try, or even if that's necessary.  Perhaps
> > someone can figure this out sometime.
> 
> b4 gives a base commit, but I think because the trees are rebased it ends
> up being the incorrect one.
> 
> Not sure what the solution is!
> 

We have seen this on the Xe list (our list is based on drm-tip),
typically with cross-subsystem patches. Some cross-subsystem patches
apply and run correctly, while others do not but public CI flows run
based on drm-tip. I do not have a bisect or a clear understanding of
what works and what doesn't, but I think it would be very useful if the
community could better understand the root cause.

Matt

> >
> > maybe
> >
> > hp2:/usr/src/linux-next> git log --oneline | grep "mm/vma: introduce VMA anon page offset field and add helpers"
> > 249646a587dc mm/vma: introduce VMA anon page offset field and add helpers
> >
> > base-commit: 249646a587dc^
> >
> > But that requires that Sashiko be able to poke around in linux-next
> > from previous days.
> >
> > > v5:
> > > * Accumulated tags (thanks everybody!)
> > > * Removed the final 4 patches to be handled later as there are nuances with
> > >   the /dev/zero stuff we need to figure out, as discussed with David.
> > > * Updated the cover letter to reflect this.
> > > * Added comments to vma_flags_is_cow_mapping(),
> > >   vma_[desc_]is_cow_mapping() as per Suren.
> > > * Correct typo as per Suren.
> > > * Reworded test comment in patch 16 from 'fault in' to 'trigger a CoW
> > >   fault' as per David.
> > > * Fix -> 75 char limit in patch 12's commit msg.
> >
> > Here's how v5 altered mm.git.  It's rather substantial, but mainly
> > selftests:
> 
> Thanks for the diff, always useful!
> 
> The noise it's mostly because of dropping the final 4 commits, and as you
> say mostly test stuff that will be sent with whichever approach we decide
> on for MAP_PRIVATE-/dev/zero in the next cycle.
> 
> The actual changes elsewhere are rather trivial otherwise.
> 
> What remains, targeting 2nd week of the merge window, is heavily tested +
> fully reviewed, so all is still very sane :)
> 
> >
> >
> >  drivers/char/mem.c                                     |    8
> >  include/linux/mm.h                                     |   18 -
> >  include/linux/pagemap.h                                |    3
> >  mm/internal.h                                          |   17 -
> >  mm/vma.c                                               |   52 ----
> >  mm/vma.h                                               |    3
> >  mm/vma_internal.h                                      |    1
> >  tools/testing/selftests/mm/merge.c                     |  106 ----------
> >  tools/testing/selftests/proc/proc-self-map-files-001.c |    2
> >  tools/testing/selftests/proc/proc-self-map-files-002.c |    2
> >  tools/testing/vma/include/dup.h                        |   40 ---
> >  tools/testing/vma/tests/mmap.c                         |   50 ----
> >  12 files changed, 40 insertions(+), 262 deletions(-)
> >
> > --- a/drivers/char/mem.c~b
> > +++ a/drivers/char/mem.c
> > @@ -506,7 +506,11 @@ static int mmap_zero_prepare(struct vm_a
> >  	if (vma_desc_test(desc, VMA_SHARED_BIT))
> >  		return shmem_zero_setup_desc(desc);
> >
> > -	/* MAP_PRIVATE semantics are taken care for us by core mm. */
> > +	/*
> > +	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
> > +	 * of /dev/zero anonymous, despite it not being.
> > +	 */
> > +	vma_desc_set_anonymous(desc);
> >  	return 0;
> >  }
> >
> > @@ -694,7 +698,7 @@ static const struct memdev {
> >  #ifdef CONFIG_DEVPORT
> >  	[4] = { "port", &port_fops, 0, 0 },
> >  #endif
> > -	[DEVZERO_MINOR] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
> > +	[5] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
> >  	[7] = { "full", &full_fops, 0, 0666 },
> >  	[8] = { "random", &random_fops, FMODE_NOWAIT, 0666 },
> >  	[9] = { "urandom", &urandom_fops, FMODE_NOWAIT, 0666 },
> > --- a/include/linux/mm.h~b
> > +++ a/include/linux/mm.h
> > @@ -740,9 +740,6 @@ static inline bool fault_flag_allow_retr
> >  	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
> >  	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
> >
> > -/* /dev/zero minor device number. Special due to MAP_PRIVATE semantics. */
> > -#define DEVZERO_MINOR	5
> > -
> >  /*
> >   * vm_fault is filled by the pagefault handler and passed to the vma's
> >   * ->fault function. The vma's ->fault is responsible for returning a bitmask
> > @@ -1554,6 +1551,11 @@ static inline void vma_set_anonymous(str
> >  	vma->vm_ops = NULL;
> >  }
> >
> > +static inline void vma_desc_set_anonymous(struct vm_area_desc *desc)
> > +{
> > +	desc->vm_ops = NULL;
> > +}
> > +
> >  static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
> >  {
> >  	return !vma->vm_ops;
> > @@ -2279,8 +2281,7 @@ void unpin_folios(struct folio **folios,
> >   * All mappings backed by anonymous folios (all anonymous mappings and most
> >   * MAP_PRIVATE-file backed ranges) are CoW mappings.
> >   *
> > - * All other mappings (including all writable MAP_SHARED mappings) are
> > - * non-CoW.
> > + * All other mappings (including all MAP_SHARED mappings) are non-CoW.
> >   *
> >   * The criteria are !VMA_SHARED_BIT, VMA_MAYWRITE_BIT.
> >   *
> > @@ -2317,7 +2318,7 @@ static inline bool vma_flags_is_cow_mapp
> >
> >  /**
> >   * vma_is_cow_mapping() - Is this VMA a CoW mapping?
> > - * @vma: The VMA to check.
> > + * @desc: The VMA to check.
> >   *
> >   * See vma_flags_is_cow_mapping() for details.
> >   *
> > @@ -4407,8 +4408,9 @@ static inline unsigned long vma_pages(co
> >   * If @vma is a MAP_PRIVATE file-backed mapping, then this returns the
> >   * page offset within the file.
> >   *
> > - * Edge cases: nommu does not abide by these and CoW MAP_PRIVATE-pfnmap regions
> > - * have their page offset set to the first PFN in the range.
> > + * Edge cases: nommu does not abide by these, MAP_PRIVATE-/dev/zero satisfies
> > + * vma_is_anonymous() but has file-backed page offset, and MAP_PRIVATE-pfnmap
> > + * regions have their page offset set to the first PFN in the range.
> >   *
> >   * Returns: The page offset of the start of @vma.
> >   */
> > --- a/include/linux/pagemap.h~b
> > +++ a/include/linux/pagemap.h
> > @@ -1128,7 +1128,8 @@ static inline pgoff_t linear_anon_page_i
> >  	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
> >
> >  	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
> > -	if (vma_is_anonymous(vma))
> > +	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
> > +	if (vma_is_anonymous(vma) && !vma->vm_file)
> >  		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
> >
> >  	return pgoff;
> > --- a/mm/internal.h~b
> > +++ a/mm/internal.h
> > @@ -240,18 +240,15 @@ static inline int mmap_file(struct file
> >  {
> >  	int err = vfs_mmap(file, vma);
> >
> > +	if (likely(!err))
> > +		return 0;
> > +
> >  	/*
> > -	 * Either we tried to call the file hook for mmap() and an error arose
> > -	 * or a driver set vma->vm_ops = NULL intending there to be no VMA
> > -	 * operations.
> > -	 *
> > -	 * In the former case the VMA is in an inconsistent state and we mustn't
> > -	 * invoke any further hooks on it, in the latter case the hook actually
> > -	 * wanted no further hooks to be invoked, so fix both by setting dummy
> > -	 * VMA ops.
> > +	 * OK, we tried to call the file hook for mmap(), but an error
> > +	 * arose. The mapping is in an inconsistent state and we must not invoke
> > +	 * any further hooks on it.
> >  	 */
> > -	if (unlikely(err || !vma->vm_ops))
> > -		vma->vm_ops = &vma_dummy_vm_ops;
> > +	vma->vm_ops = &vma_dummy_vm_ops;
> >
> >  	return err;
> >  }
> > --- a/mm/vma.c~b
> > +++ a/mm/vma.c
> > @@ -2621,36 +2621,6 @@ static int __mmap_new_file_vma(struct mm
> >  	return 0;
> >  }
> >
> > -static bool map_is_dev_zero(const struct mmap_state *map)
> > -{
> > -	const struct file *file = map->file;
> > -	struct inode *inode;
> > -
> > -	if (!file)
> > -		return false;
> > -	inode = file_inode(file);
> > -	if (!S_ISCHR(inode->i_mode))
> > -		return false;
> > -	return imajor(inode) == MEM_MAJOR && iminor(inode) == DEVZERO_MINOR;
> > -}
> > -
> > -static void map_set_anon(struct mmap_state *map)
> > -{
> > -	map->file = NULL;
> > -	map->vm_ops = NULL;
> > -	map->pgoff = map->addr >> PAGE_SHIFT;
> > -}
> > -
> > -static bool map_is_private(const struct mmap_state *map)
> > -{
> > -	return !vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
> > -}
> > -
> > -static bool map_is_anon(const struct mmap_state *map)
> > -{
> > -	return map_is_private(map) && !map->file;
> > -}
> > -
> >  /*
> >   * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
> >   * possible.
> > @@ -2664,7 +2634,8 @@ static bool map_is_anon(const struct mma
> >  static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
> >  	struct mmap_action *action)
> >  {
> > -	const bool is_anon = map_is_anon(map);
> > +	const bool is_anon = !map->file &&
> > +		!vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
> >  	struct vma_iterator *vmi = map->vmi;
> >  	int error = 0;
> >  	struct vm_area_struct *vma;
> > @@ -2806,10 +2777,6 @@ static int call_mmap_prepare(struct mmap
> >  	if (err)
> >  		return err;
> >
> > -	/* Hooks cannot mark themselves anonymous. */
> > -	if (!desc->vm_ops)
> > -		return -EINVAL;
> > -
> >  	err = call_action_prepare(map, desc);
> >  	if (err)
> >  		return err;
> > @@ -2826,21 +2793,16 @@ static int call_mmap_prepare(struct mmap
> >  	map->vm_ops = desc->vm_ops;
> >  	map->vm_private_data = desc->private_data;
> >
> > -	/*
> > -	 * MAP_PRIVATE-/dev/zero mappings are an ancient way of getting
> > -	 * anonymous mappings. Rather than allowing these mappings to be odd
> > -	 * outliers, simply make them truly anonymous.
> > -	 */
> > -	if (map_is_private(map) && map_is_dev_zero(map))
> > -		map_set_anon(map);
> > -
> >  	return 0;
> >  }
> >
> >  static void set_vma_user_defined_fields(struct vm_area_struct *vma,
> >  		struct mmap_state *map)
> >  {
> > -	vma->vm_ops = map->vm_ops;
> > +	if (map->vm_ops)
> > +		vma->vm_ops = map->vm_ops;
> > +	else	/* Only /dev/zero should do this. */
> > +		vma_set_anonymous(vma);
> >  	vma->vm_private_data = map->vm_private_data;
> >  }
> >
> > @@ -2920,7 +2882,7 @@ static unsigned long __mmap_region(struc
> >  		allocated_new = true;
> >  	}
> >
> > -	if (have_mmap_prepare && !map_is_anon(&map))
> > +	if (have_mmap_prepare)
> >  		set_vma_user_defined_fields(vma, &map);
> >
> >  	__mmap_complete(&map, vma);
> > --- a/mm/vma.h~b
> > +++ a/mm/vma.h
> > @@ -267,6 +267,9 @@ static inline void assert_sane_pgoff(str
> >  	 */
> >  	if (!vma_is_anonymous(vma))
> >  		return;
> > +	/* MAP_PRIVATE-/dev/zero is anon, non-NULL vm_file, but has file pgoff. */
> > +	if (vma->vm_file)
> > +		return;
> >  	/* If faulted in, could have been remapped. */
> >  	if (vma->anon_vma)
> >  		return;
> > --- a/mm/vma_internal.h~b
> > +++ a/mm/vma_internal.h
> > @@ -23,7 +23,6 @@
> >  #include <linux/ksm.h>
> >  #include <linux/khugepaged.h>
> >  #include <linux/list.h>
> > -#include <linux/major.h>
> >  #include <linux/maple_tree.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/mm.h>
> > --- a/tools/testing/selftests/mm/merge.c~b
> > +++ a/tools/testing/selftests/mm/merge.c
> > @@ -1324,7 +1324,7 @@ TEST_F(merge, anon_and_page_offset_misma
> >  	ASSERT_NE(ptr, MAP_FAILED);
> >
> >  	/*
> > -	 * Map another separately and trigger a CoW fault, at page offset 5:
> > +	 * Map another separately and trigger a CoW fault at page offset 5:
> >  	 *
> >  	 * |-----------|           |---------|
> >  	 * | unfaulted |           | faulted |
> > @@ -1362,110 +1362,6 @@ TEST_F(merge, anon_and_page_offset_misma
> >  	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 5 * page_size);
> >  }
> >
> > -TEST_F(merge, merge_map_private_dev_zero_unfaulted)
> > -{
> > -	struct procmap_fd *procmap = &self->procmap;
> > -	unsigned int page_size = self->page_size;
> > -	char *carveout = self->carveout;
> > -	char *ptr, *ptr2;
> > -	int fd_zero;
> > -
> > -	if (access("/dev/zero", F_OK))
> > -		SKIP(return, "No /dev/zero.");
> > -	fd_zero = open("/dev/zero", O_RDWR);
> > -	ASSERT_NE(fd_zero, -1);
> > -
> > -	/*
> > -	 * Map two MAP_PRIVATE-/dev/zero VMAs next to one another with offset 0
> > -	 * each.
> > -	 *
> > -	 * With these being made truly anonymous upon mapping, they will
> > -	 * merge. If they were file-backed VMAs the page offsets would prevent
> > -	 * merge:
> > -	 *
> > -	 * |-----||------|    |-------------|
> > -	 * | ptr || ptr2 | -> |     ptr     |
> > -	 * |-----||------|    |-------------|
> > -	 */
> > -	ptr = mmap(carveout, 5 * page_size, PROT_READ | PROT_WRITE,
> > -		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
> > -	if (ptr == MAP_FAILED) {
> > -		close(fd_zero);
> > -		ASSERT_TRUE(false);
> > -	}
> > -	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
> > -		   PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
> > -	if (ptr2 == MAP_FAILED) {
> > -		close(fd_zero);
> > -		ASSERT_TRUE(false);
> > -	}
> > -	close(fd_zero);
> > -
> > -	/* Assert that they merged. */
> > -	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> > -	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> > -	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
> > -}
> > -
> > -TEST_F(merge, merge_map_private_dev_zero_faulted_unfaulted)
> > -{
> > -	struct procmap_fd *procmap = &self->procmap;
> > -	unsigned int page_size = self->page_size;
> > -	char *carveout = self->carveout;
> > -	char *ptr, *ptr2;
> > -	int fd_zero;
> > -
> > -	if (access("/dev/zero", F_OK))
> > -		SKIP(return, "No /dev/zero.");
> > -	fd_zero = open("/dev/zero", O_RDWR);
> > -	ASSERT_NE(fd_zero, -1);
> > -
> > -	/*
> > -	 * Map a MAP_PRIVATE mapping of /dev/zero with page offset 0, then fault
> > -	 * it in:
> > -	 *
> > -	 * |-------------------------------|
> > -	 * |           faulted             |
> > -	 * |-------------------------------|
> > -	 */
> > -	ptr = mmap(carveout, 15 * page_size, PROT_READ | PROT_WRITE,
> > -		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
> > -	if (ptr == MAP_FAILED) {
> > -		close(fd_zero);
> > -		ASSERT_TRUE(false);
> > -	}
> > -	memset(ptr, 'x', 15 * page_size);
> > -
> > -	/*
> > -	 * Unmap the middle:
> > -	 *
> > -	 * |---------|           |---------|
> > -	 * | faulted |           | faulted |
> > -	 * |---------|           |---------|
> > -	 */
> > -	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
> > -
> > -	/*
> > -	 * Map in a new unfaulted mapping in the middle with page offset 0 -
> > -	 * this should merge and would not if it were treated as a file rather
> > -	 * than pure anon:
> > -	 *
> > -	 * |---------|-----------|---------|
> > -	 * | faulted | unfaulted | faulted |
> > -	 * |---------|-----------|---------|
> > -	 */
> > -	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
> > -		    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE,
> > -		    fd_zero, 0);
> > -	close(fd_zero);
> > -	ASSERT_NE(ptr2, MAP_FAILED);
> > -
> > -	/* Assert that they merged. */
> > -	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> > -	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> > -	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
> > -}
> > -
> >  TEST_F(merge_with_fork, mremap_faulted_to_unfaulted_prev)
> >  {
> >  	struct procmap_fd *procmap = &self->procmap;
> > --- a/tools/testing/selftests/proc/proc-self-map-files-001.c~b
> > +++ a/tools/testing/selftests/proc/proc-self-map-files-001.c
> > @@ -51,7 +51,7 @@ int main(void)
> >  	int fd;
> >  	unsigned long a, b;
> >
> > -	fd = open("/proc/self/exe", O_RDONLY);
> > +	fd = open("/dev/zero", O_RDONLY);
> >  	if (fd == -1)
> >  		return 1;
> >
> > --- a/tools/testing/selftests/proc/proc-self-map-files-002.c~b
> > +++ a/tools/testing/selftests/proc/proc-self-map-files-002.c
> > @@ -57,7 +57,7 @@ int main(void)
> >  	int fd;
> >  	unsigned long a, b;
> >
> > -	fd = open("/proc/self/exe", O_RDONLY);
> > +	fd = open("/dev/zero", O_RDONLY);
> >  	if (fd == -1)
> >  		return 1;
> >
> > --- a/tools/testing/vma/include/dup.h~b
> > +++ a/tools/testing/vma/include/dup.h
> > @@ -15,21 +15,6 @@ struct task_struct *get_current(void);
> >  #define MMF_HAS_MDWE	28
> >  #define current get_current()
> >
> > -#define MINORBITS	20
> > -#define MINORMASK	((1U << MINORBITS) - 1)
> > -
> > -#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
> > -#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
> > -#define MKDEV(ma, mi)	(((ma) << MINORBITS) | (mi))
> > -
> > -#define S_IFMT  00170000
> > -#define S_IFCHR  0020000
> > -
> > -#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
> > -
> > -#define MEM_MAJOR		1
> > -#define DEVZERO_MINOR	5
> > -
> >  /*
> >   * Define the task command name length as enum, then it can be visible to
> >   * BPF programs.
> > @@ -38,8 +23,6 @@ enum {
> >  	TASK_COMM_LEN = 16,
> >  };
> >
> > -typedef unsigned short		umode_t;
> > -
> >  /* PARTIALLY implemented types. */
> >  struct mm_struct {
> >  	struct maple_tree mm_mt;
> > @@ -62,10 +45,6 @@ struct address_space {
> >  	unsigned long		flags;
> >  	atomic_t		i_mmap_writable;
> >  };
> > -struct inode {
> > -	umode_t			i_mode;
> > -	dev_t			i_rdev;
> > -};
> >  struct file_operations {
> >  	int (*mmap)(struct file *, struct vm_area_struct *);
> >  	int (*mmap_prepare)(struct vm_area_desc *);
> > @@ -73,7 +52,6 @@ struct file_operations {
> >  struct file {
> >  	struct address_space	*f_mapping;
> >  	const struct file_operations	*f_op;
> > -	struct inode			*f_inode;
> >  };
> >  struct anon_vma_chain {
> >  	struct anon_vma *anon_vma;
> > @@ -1660,23 +1638,9 @@ static inline pgoff_t linear_anon_page_i
> >  	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
> >
> >  	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
> > -	if (vma_is_anonymous(vma))
> > +	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
> > +	if (vma_is_anonymous(vma) && !vma->vm_file)
> >  		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
> >
> >  	return pgoff;
> >  }
> > -
> > -static inline struct inode *file_inode(const struct file *f)
> > -{
> > -	return f->f_inode;
> > -}
> > -
> > -static inline unsigned iminor(const struct inode *inode)
> > -{
> > -	return MINOR(inode->i_rdev);
> > -}
> > -
> > -static inline unsigned imajor(const struct inode *inode)
> > -{
> > -	return MAJOR(inode->i_rdev);
> > -}
> > --- a/tools/testing/vma/tests/mmap.c~b
> > +++ a/tools/testing/vma/tests/mmap.c
> > @@ -45,57 +45,7 @@ static bool test_mmap_region_basic(void)
> >  	return true;
> >  }
> >
> > -static int dummy_mmap_prepare(struct vm_area_desc *desc)
> > -{
> > -	return 0;
> > -}
> > -
> > -static bool test_pure_anon_dev_zero(void)
> > -{
> > -	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> > -			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
> > -	const struct file_operations f_op = {
> > -		.mmap_prepare = dummy_mmap_prepare,
> > -	};
> > -	struct inode inode = {
> > -		.i_mode = S_IFCHR,
> > -		.i_rdev = MKDEV(MEM_MAJOR, DEVZERO_MINOR),
> > -	};
> > -	struct file file = {
> > -		.f_inode = &inode,
> > -		.f_op = &f_op,
> > -	};
> > -	struct mm_struct mm = {};
> > -	struct vm_area_struct *vma;
> > -	unsigned long addr;
> > -	VMA_ITERATOR(vmi, &mm, 0);
> > -
> > -	current->mm = &mm;
> > -
> > -	/*
> > -	 * Map a MAP_PRIVATE-/dev/zero mapping at address 0x300000 with a page
> > -	 * offset of 0x10, which we expect to be reset to the anonymous page
> > -	 * offset.
> > -	 */
> > -	addr = __mmap_region(&file, 0x300000, 0x3000, vma_flags, 0x10, NULL);
> > -	ASSERT_EQ(addr, 0x300000);
> > -
> > -	/* Assert that it truly is an anonymous mapping. */
> > -	vma = vma_lookup(&mm, addr);
> > -	ASSERT_NE(vma, NULL);
> > -	ASSERT_TRUE(vma_is_anonymous(vma));
> > -	ASSERT_EQ(vma->vm_file, NULL);
> > -	ASSERT_EQ(vma->vm_private_data, NULL);
> > -	/* Expect anonymous page offsets. */
> > -	ASSERT_EQ(vma->vm_pgoff, 0x300);
> > -	ASSERT_EQ(vma_start_anon_pgoff(vma), 0x300);
> > -
> > -	cleanup_mm(&mm, &vmi);
> > -	return true;
> > -}
> > -
> >  static void run_mmap_tests(int *num_tests, int *num_fail)
> >  {
> >  	TEST(mmap_region_basic);
> > -	TEST(pure_anon_dev_zero);
> >  }
> > _
> >
> 
> --
> Cheers, Lorenzo
