Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795190392;
	b=PWqVgPdYChhXNwMxLcbGpNuXFK54NgtXgm8l5Zgl+onBbl86vn92nspTu4wzcQmyewsR
	 cclkhIJwdjvzK0gcdPvG2vukkRxRn2BgS9uHSpy3jUZ4aRzJvyUFwMs3XnhbTRm7cFVWP
	 44hwfvYvGXAilm1S9sRRwnyfidbj0zwJnB8C82BRbUTBbssjq7480bgeqDLou6MYpOpNg
	 5R557WBwd6Q4S575qftDkfESTjW4estaqVfWlWSylGXPyPIdeupP9HBUwdC9Vbrw0KDXs
	 DdDEGg1G3RugYzQ6/xES/Vpgg1722h2J9/y1rsgxgvPxbSLapsVW9EDyg3h05VveF+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190392;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QsVY//bu9ZEXQaW9BRArY8yIP8+vZ7c6IQ/kIbeWyFQ=;
	b=M/tku39xxZSQTgo3fkxTErWebCRIcLh35o+JIvUY3x9bZmdzGX2QZt/cc1gwUufihtW0
	 4Wb6gAa/K+/DoB5V9/+fkRKO6WL2rFEVN8fYylxVNAhlckuoZeYc0qhXhHND9yqaeDDlG
	 pKm/5KhyNz6uYe7PxM7IcbYhxYwJQs00rdrzEDAJ9lH0cyzChZd6h3vwa2Ieq9Iypq3eR
	 7RO4rzmSvmIcWSGULEuBRPnZRo409x/AaKxSrer9+BvDHc4iHMf8FPrNu8jQ70hOi1Jfl
	 PJzqrAGRRT0mfYOklNOheMgFMkFUu1ZKO40Ggv5p8Xu37EH3mWIhs7QVxmS51oh2oXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nbzyIVbK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.43
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5950606A333;
	Fri, 20 Nov 2026 15:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5950606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nbzyIVbK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb3ci456cOBCV0nTs5Ik7SLsVwIouBNBzDNGC/7PZg/lvVeLcprzoL0oUq0oOzJQjLGnAxHDz19yGiPUiRGWygYGfgSVKLt+fEHNe6fuVOiWFBads7YpkgU1bPmmz3BzxyhlRYf/HFyo6bASVRombXlCmoP2uTsiyu/autZAiYE+3WVt2WhiOc+J3fO+nZUkQtd7b87n8R3tTgBuRzMHu/dBsYHh/Ek5s/V/SqH/R0aax3mHCnuxFnFcI+bDjENmqnPGQiuapcEJ00/siZcWc8Qkk47+ryHEQF3eWZhMI/0LRZMHiGH/4+fLHzghS0TVUlGf8S9tJPpXkncXHB5Rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsVY//bu9ZEXQaW9BRArY8yIP8+vZ7c6IQ/kIbeWyFQ=;
 b=pH3DtUp8AftbeX+OzwVB5UAlOySdUeLCvwOXc4gj441AksmJWhitJgWnCSurlwC/ku8rTdgOruIvqmaqcEx9De5RBEUiXHzg10cwR5BlUqHHTOx3hBirrk+s6a3ZOvYN2gdpCB+zCyVrJVYO4T6KEI1E8cqL5rQDVkzA9j1ahY8eOiJDyDzLmAocdQz6l3l1kDrLGksdLsl2r95c0pbnen9i+eNPwNZu3R9J6dhDBhfpBZVwRDQL3DZkkxLh3eycW+Cqv73fAPpeGsX+W7pWN+PiwVW+GcwY1redjpfgMh7jOAdOxwZunDmAblsxBXglvBL/X759tPDQYJiqjbLsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsVY//bu9ZEXQaW9BRArY8yIP8+vZ7c6IQ/kIbeWyFQ=;
 b=nbzyIVbKZjLEsD8m//kA7UoB9X8o/cTjm+NCtGL49fKbf3bH+C+os/z1eoFWxBXcFUwxdUvUtivmGZrcCI7IEedOK4uLyUk4nHUl4HY468GUohYACoo7Q3KqZdfVg2+7zoFhginnOY7tkp0WMAH98PfRuH2jI0GzLRn+SrR43OPg1zAS4PKYq3Cg/uiEEdiexiEmNlphb7NRvTfTJlH6SKHuHRBCOyKc9NS74IzGlnTExKkEBo8T700PerqaYCv8m+XKAZZFin/R0E2fXemg79NNiLAugO4ygQTR/b0Hod//OpA2BTFButVs+7Y+DbUgitUG0DaiE5N3UY25M6Rc1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:59:45 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 15:59:45 +0000
Date: Fri, 20 Nov 2026 10:59:43 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 7/7] cpu: make preferred CPU policy writers mutually
 exclusive
Message-ID: <awBub4wgnTnsqL7i@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-8-ynorov@nvidia.com>
 <20261120153851.GX2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120153851.GX2668564@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: CH0PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:610:77::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d86a0b-76f9-4035-f7d8-08df471f4bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10070799003|18002099003|22082099003|3023799007|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZUQtNC+XS6sGZxLxCvW8OL0h2LaX6qBfRa8wv8Rvv0LtXt2tqjt5iEAD4KX9TlJIUUPnWH+eRjHzAlqP/bW8Jp02w4t73W6wqbECw9uxj/2ypAaLoULIz9bpXn8Q0EwPZOQiKQk/LIwpcQ7tzf3mprsP9IBt5kwCalzIUfxTM5URaUstpYGJSGH6K/rL7CNOO3x5huknWDLqCtVI44mpmh4aFJaWQmyPd9BYYqczH1NjjBXkzFhPKJk0SsQ0IOEWqg5/jWn2LSgtRVW5XtaIovCma5D71nSPNnnfEwzSGPD/EoVttRDoQQZSmkc7BA79kxU1ZYGMmicw+WTpR7Hd3ms/Zk9aGivrecLXi5xPOGnt/o7g5oHni+hacij4i/ZdwXihIx8gHJvcU5s+QyERo5looWg3U+3KE1VIG1jXs1B44o60IS4F+FSI8LFuIB78hzm/fWzO2Twl1XL+uEsvehnXL3pU5HUpSlkLaDHfQAS6jkFVCU0NVv0nYaFE1m9krk5pdszG0erNc0T8kUXkOJI2LMxSDeNB942pnOyB4ybk709O1TjpKd80D+d2TZ5gp+k4k2fdF+Tx8iBnqSxeDZSyjcX5/327h8jgxomGJUiwMJX/uo9dPe3zUZe4lyN/+p9yEl0QWiwvvxUEbGJOMU/wOZI/qHvJHqrU808x5NY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10070799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmTtaQfho1QgFTh27FdOAL3MGrHw1nOxHGICZWEnG2XNGxIuUE6bXbiezFk0?=
 =?us-ascii?Q?x5AuUmudVaQn4vU7QyACsXiOLnb+Ljyt6EhQn5/UN7odopz30wO3neMMSoEb?=
 =?us-ascii?Q?UMygyRbbqX5osy5YCG4py4IsyIJGG3SaxCqCUsdSzE0bQ0sazozh+k+eTv93?=
 =?us-ascii?Q?2+K/aYaadaYPjeKmxKWlI1rfRQ697ElIJLrGg279xNTQ4nLtW64XlCbZn23j?=
 =?us-ascii?Q?CBu2//7R+7zfg/v4vtHJapU2yEziHuogYeFlpGmVxSP9uSpYu7MJ9gwyx+97?=
 =?us-ascii?Q?drmxEzyrL8k3DoKiUCgd+7qDQ0u/yhm4IODo60efuV3RHao6K9byKM8KnLp6?=
 =?us-ascii?Q?3wsYrunT/jZljP3bH75/ffFEEctHS0k1BwXM+cdMmt6WbdDMsAL6IsDjD2wv?=
 =?us-ascii?Q?31pEGsZOus5xacc9s06Y7Upxum8zes/9eRNS/ij/Lr+C8NvC371Qq22WPzUt?=
 =?us-ascii?Q?7Qo15fjcksNCZJtUs3KxlPrpEsO3QQUmpCtMQjrAnUlpo3UCVfxUTRfhaJLq?=
 =?us-ascii?Q?1sq4PqLpUsY2Qi+hRWO5pTSxAYEDzkRnbmxj3HoQe43gqWOYHxavKlvuS1dO?=
 =?us-ascii?Q?jt7zkRlMsE0icVKQrMmKZJy7+wmpwvXToqwRfsuOhDyFL+79+AcIx/jv+D7f?=
 =?us-ascii?Q?Gdldo9klTwWD+/eLYZuVbU2wm93kSDSRXSsC/T/u5x+fD25vYmq8C505qqYF?=
 =?us-ascii?Q?HN0L/GHo1PTlJTnVEKecxGJEMg4bynlzloNE89sALO0mAhp8Jt9ZBetaUOPx?=
 =?us-ascii?Q?QZCwEzUgUwX7sYbqNkstn6QcJGO9tcPO4wFkoGbex83s15XVwa6SgIdBa0+O?=
 =?us-ascii?Q?xgamXSNGHZUlX3Ofs/YYA/VjDHc2yxjX6ZSOAnVKCOuHnxVtkhoBOGIQR7Ou?=
 =?us-ascii?Q?DnWLRPOVGhBPLETZqHXfUmfdTU+/aisJW2mCxEcP69zaDMx5LlIWHJANvxjV?=
 =?us-ascii?Q?dtz+XsELDK7G60ptPh5qCZfhFEeuIS7qGLaSq8mAyODsxyc/EQcqABBKTj0A?=
 =?us-ascii?Q?6ZizTCk67Gy0t4RsrwKwlhqBziRuBjVWxvpbybeDhuKD01Tn7laQN4lkRGB1?=
 =?us-ascii?Q?nqSA4u+FC0ITKCrfByns9pGxtQXplkPYEPEUlDQigawaJJkXo+iAtWEz6YzL?=
 =?us-ascii?Q?eLTdHifykSJ78dqXhIm6YckZ3dQNDrYa0QNVdyY/TIGUJPNHsq3e9ESwhyzp?=
 =?us-ascii?Q?yOX8fE2mrywc9egSjh79Y2+ygZdtGYeoARbMsX8nPPR+MMmhcbHIRFXunPWk?=
 =?us-ascii?Q?YPQ4/ShCJuXf/rhaSOpgt1uPQ92+fDmz+ifchMXD7sLXkSUtaazi1yz5HS9i?=
 =?us-ascii?Q?1CC3guAb3US56H7XZUeroLF3BkOIqs0+jXF+vqBab/r6M5rUYQeXqaQ2hHO2?=
 =?us-ascii?Q?1WHA6X68vdyXoRgL8kIhA9gAg+IWEXQPnXuHkR7j5n6+e8ri7wbOWMwvRi6Y?=
 =?us-ascii?Q?0NRKEJ+UrSYoprLFvWpgK12ab2l81BPRt4Iq3OqmtebkLRIXX8IZgBIBcEsR?=
 =?us-ascii?Q?iKBFZDi1+Z3vu3xa7GwtbXUjibeBEZpJokhfe3vnOXTvmXD9170xNBYxvd/v?=
 =?us-ascii?Q?HxAPs5HuZnpIAawTW4QhgBaa94IqYWcQJ/svxqAGJCVeNygS5Qox29doFib3?=
 =?us-ascii?Q?Jjl7Ns9uhl1+kAacahErlMY5smcYIYmk7H8kFSvzdy4s1o64Kz5W/2QmOumu?=
 =?us-ascii?Q?cI/ghAx5fz10ZNMpeCoXS+r0EveU/GpHDn3182NDz2f6YL8lbNX9ejHEtgoy?=
 =?us-ascii?Q?vVaS0gChzJc4tK5hmzFYUHS0PCg5m6er7VJitD6YgXZFGvhAXeV0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d86a0b-76f9-4035-f7d8-08df471f4bab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:59:45.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM4Max2R32mmj36hz1qMfW+Oc1PL9OJ+6/liv2BsRizAZBfyNtpeAhM0KHkbgst4DpQ3c2/QuzWlQ1uL5QYl9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

On Fri, Nov 20, 2026 at 04:38:51PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 13, 2026 at 01:42:56PM -0500, Yury Norov wrote:
> > Serializing preferred mask updates still lets competing policy drivers
> > repeatedly override each other's selections.
> 
> Competing controllers is not going to happen.

That's the purpose of this patch. You can't stop people writing
alternative controllers, but you can make them non-competing.
