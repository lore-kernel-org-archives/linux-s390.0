Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795110472;
	b=uHO9/lZZrFs8KeI/inX8O5gak4BUx1EFrCR81/TMEESI4ItNEyrIHWnv4rdetJaPsPk+
	 /eGgDg5TIqBkATNqxXQOz2aVL7TLeVreuquf/Vge26LpXRNFxEaeKUu5lla9ZZ6d0D6Yb
	 TjobbaWvjwOM3VJLTpZdLMMvQBknISgOB3SYOIxhi3fm7b+XwwbBKwdytegBEiCB2l2pq
	 nL3iFNiNeu8oCkDgiBlWQkYTNKiLsnpr/8QYoYslznipocwd2wETWtOVPY+XeOyOSiEeq
	 a5vKvh0Yp5eK7HiyIq+r5dQCC2k9Bufyw9IAj5hApQ2nyKbLlEhmRN9IyO0HuymJwfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110472;
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
	bh=rqWyCMM54wAN8kO+pQl5Iju9TPkEZT6JgNNqkGhGwMc=;
	b=IOn5O/Bkt7hZ75qBn/CYdXXqzl9N9aCDZVwW0tD2pLa58s3kWNIz3+DxzaId3qCE0gNX
	 PoLXafty9s18AOlMDVuDbHnDb3VZi9Uoy6CZSZq+EPHczs7X/4MqklNyPGcp0PEb8WdTT
	 UCXv4rKgbSJ8DIZ1X6JSpBOv8bsdFekSfQoZunTQL3dUl17p+b2Ak0ynjQqplpC4SX399
	 qIBJ1qtfUghOZoaQvk9u7/TRPS/pXIYyI6lKdQzxKDdY90D/31M3KV9s5ZCmRp0ltxzTN
	 43ArULkI9sHaDi0ZA4xhoa/EiAsdjZCa8IRvkm/m+ZbXfKn6ELbqU/x4UtFdfKD9eEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NZsgyV5g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.28
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FED606A324;
	Thu, 19 Nov 2026 17:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09FED606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NZsgyV5g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc9awxxPke6TtuL5ZwCNWeBh4wRAdFsg8her3Xf3DSXPBrnTIkBV+GolF23FaCPYQc2qSESkk7lCnVQikLkqSlAdmWfVsmpjcR6nudpbHSRd/S6ciGIAfqfoacEhEOQsJAtbhpTkybt4x06ucik4itxEHMKx4ArfHzmBlk1vRzoLR+uQrP9hWpvB3se1602JREhSrg0tfFCZU7qe57NMA2T1vws1lh0O3bz9VJTd9S14fwfvv/COtF+jBiFdj7ODXsUr/oHMS1wUrKz54MjOSQZCC7jsP/nXq7eylZJZKxq5xBgtBDOrtXGERb0PqmB/nXxmCz2cBQIfPbt7qi3jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqWyCMM54wAN8kO+pQl5Iju9TPkEZT6JgNNqkGhGwMc=;
 b=oHURriNsscnxpvnSjyOkdRSylZALVpLBMrL7FJGieD17IYKT2SC9KfoYXSxeLHT0yvjL3ckPF0jMDYQaQt3kE/WFmCXUi0HSiMX0tvo6iEkZtIb1vEonw5leplhLzEv8UGv9f0qagfeZmfxK6KKNJotglo1++a4kyHsQjhhfRVdxbE+viOCdy4DPTdnTkkgatcglDK0gbe6NQTO33Fg3fO+RsliJid3UAhVnpKOp3nzcDuvGEqtxz/gZFgSwQ8w5FvAFi5nstbZfKRnHD8k5due7Z/f8DzXp1YCN4Sf0EAYFZFYhAjRhI5zAmAigPBDuqMCkGKM2ZDiEZ+SZOR0cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqWyCMM54wAN8kO+pQl5Iju9TPkEZT6JgNNqkGhGwMc=;
 b=NZsgyV5gTapGT4EELtnn8p7BixrPIMzvIkBD0YzbKtyOjw1mRZi4k82UbmUhC4C6tzQWVUtS32Oip3Lv7ix77aLE2EVVj6ADgUlxoRKF05JeskiP24jAKITEBi2iiocX0ruJNsbPCvqqoA53egkOlJ6b2C2u9l+cDj6xlJxU0hBD9SCDHRYvb3R76jegTZZO2binmEYA1fGYoin0ksUl9ErDHR+G9efJHXazUq/hU1xlIWMduWdRj+LNhPG4WOlZW6N1uCR+mqmsg+fzTvAn6xXB5tMwbDsB8HQ53yAs2xdM3VOBvKeIwo7EtCfRRRRBzvAbIvXdfcVoycPnwx4Cpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:47:43 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 17:47:43 +0000
Date: Thu, 19 Nov 2026 12:47:40 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <av82PAPUeYHscBOv@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-8-ynorov@nvidia.com>
 <8a61dd54-3602-4823-b5b5-54f25c40f8e8@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a61dd54-3602-4823-b5b5-54f25c40f8e8@linux.ibm.com>
X-ClientProxiedBy: SJ0PR05CA0123.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::8) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a67e9e-7cd3-4ad2-36b4-08df46653659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006|261026121527099003|261028144727099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	36LQ/0vpD+H8cDE5fqWq3RKHFf2zpu45T6fNl4ZtpYST95wbJ0vlDaZTQa96VFaBIacXqpGd4cIOe6GAVEr0XEfu80QtIBX1QfxrGsLnLz8+44Lt67VnZMX+tJJYCdYtny0YlU5D7zGUiehl/b9jvsEXEYxinCKg+fh+mBrfrYscx/58zTkjKHIr19v1BMGBFVQqoC6czf+xhjtkJ/2p/qYV+Pc4NysHSpyfzssELjaFkNWJUjVE40rNO9dEA1Qu4Nv/pgrnNYAw4p7i9eyW6TIWq8ZRx737fOxspNsGLvB6oc1jks9Kp+uf+l1ZG1EmURPMPac8zrUoXfuKG2sCIDdXGl6I7Po9rHgLJtnXYUBLLCvi5KMk9UTDTZ9sbvwAwoYJ3F+RFrg/f/obDfbwN3OHbO70M9MkfiLXR7WCe8oclsHyB84rRR5f2VC128VUz5VUw7uKl88uOFJ5JLjXPd8DTC2UYddjeSfXR1cVLhJZ/UI0JgsgPg9q4qrbTv7ph2BEiFTYSpuWKsHnmpON+rjxWgbg+s5F3Ua1cKD9oaK3Ky3syeIVA0Q71JCMCcY7iuHZMGzI/8z/PXV88br+LoneTBsiAI5uGfG8ez/sBSrysvDflZ6FW5ZtuJIq/yyjH9vbKLKZvIY3ASt3awpH019O/BMP51Tff/6PFad2yhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006)(261026121527099003)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MLjg6wvpuNv5Dvrhs3p8j+a/rmnJ6qMGkAO3xGSihrmjNtDbVzKHI1K0zQjs?=
 =?us-ascii?Q?MuqIC7zDzB3U3G8QoffNvZHqQoX7SUuaHdEwuAA6jBG9SI0iv3Oq/Qh8ZHtK?=
 =?us-ascii?Q?AGt54Qg7F+ks6mMh3xeojcrDYavXo9zY/MmBCj29YIb0QLwmT/YhSMbihxnb?=
 =?us-ascii?Q?0c09DusHB0rzOEtEhD90DZQlRjT9SOF8R3e/0gCDl4bHxtmSqs2UHqdlG3Wp?=
 =?us-ascii?Q?tkBDTYpjrxLktGVVDakDtHMaCZH0yVhLJuDWrnG2uxZGhrVgpI4IdNeigcTc?=
 =?us-ascii?Q?MrBsV+HSQzewmmy2gS6Syc5FjiBzdMOTT+OX2iuXb582J4Lc1kpU4PTTCo13?=
 =?us-ascii?Q?g65KZRp8Tt5rDShpDhT+lLDbMusGUvtO9j1fGcTug0mjsD56TMKqa0hJqtDF?=
 =?us-ascii?Q?o9kFFeKl+xgSJnCzcZWINNgIqNeZxFTHsWD7a+uP/OQh5t+PlNnezdM8UrS3?=
 =?us-ascii?Q?gRHqWinAOC4wPu8Vf60iUvDHF60pR38QzglIym/CDcBqpRcquP83BT/A+yIx?=
 =?us-ascii?Q?SNsHmf7M3z4jf9xITNReB6MbaX0sn5kjwDYCkIq89cqNvyTKsrg8mRRGsC69?=
 =?us-ascii?Q?usY8GYf+UllVbGBDAmmEgz4X2Xgs8ta4EoK2pHDrLctNfOwpFhKySCzxG89V?=
 =?us-ascii?Q?DL5KlyVBbOhDcsuLT/53mLZ4pM/KArZXkqEgCtDuytQNe3QyRV/I8rXvqUDw?=
 =?us-ascii?Q?AHb/z0a5w57Xk6a0Q+l3Oe4+ZS98XiZHyZTtABA+BC5c3YnH5R9d4wOArRkY?=
 =?us-ascii?Q?88lbKcS8tEvb69izPm4cvcfwYYiGLrncpMg1HDvAp51sVrU4UqDCXDPJ0QtY?=
 =?us-ascii?Q?7+lsFMvkg0E0OaUOmN3DKHYMjyWRBM8hJougpH8oq6iCeGVB7bIqt26A9f9i?=
 =?us-ascii?Q?lVwOf1L6W+VFiHdLEnT72G4eiF/AOmTw2fuVRal1und6TG52mpFcLVRBJbhd?=
 =?us-ascii?Q?K3Lu2ywKLfi9gBPVjynV8YBuSRjNkioXTzt5g/1fJkFlkFXWkyVrgF/IkG6e?=
 =?us-ascii?Q?D5aLlStrDnoZjbW6e65LzJ4bnv/ql2/Xku4v7k8TnF/+3jFibdMiLV3WTrNE?=
 =?us-ascii?Q?n73lXhIRraY47WEYuNP9A0YqP/RDkj4yrbha6UCBfVMv7P9xnuJqURoErT1D?=
 =?us-ascii?Q?oOYxB5TVi5PVvDYds6P6uuTnAgwQQ9ps9dfn0rmIbCm3FIacQJKB/+KwKG6E?=
 =?us-ascii?Q?k6qzH6BBa2mC6ZAhW1gbTQM3fJH44anbSXz9x1CbMalxypaJSVkvrv/CQaiM?=
 =?us-ascii?Q?5xhS+soZN9JbgrAoORFT3lIF9oYF0cOtP2RYZNW4M50MmKSYBP5u8d68DlXf?=
 =?us-ascii?Q?+a4hMR6bAmGG2MNVAygpf438dx/L5G5Rc+ro2d/ZfhYWjxWVM0lgQtvndvy6?=
 =?us-ascii?Q?cgnpeoZWPvSCOucY5RTy/pZVEB1Tknjqa6hiazhdB/U3URHsXsJsDAbA4uC1?=
 =?us-ascii?Q?Yi3LZ7P6EwnR0QUW/iERmjFC6MbfVJapqXnZBblOiA1xw1sp/pkWC7j4WCvh?=
 =?us-ascii?Q?ECOU1+ftzNMU/unRAOqpuLDwRo6QhvSU/rDJ/rmPHY9w/NdaGoW096H1f7aZ?=
 =?us-ascii?Q?TFvQOvgcO/eeqBt6xksa2Jr2DGXrTWdo+P9FGpkGuf6SB4cWU1NHdZP5r6sm?=
 =?us-ascii?Q?49DxvDtYLDTKM+CMBk6hJvQYoa70QDkrqnbFRQz8c2T6XhyX41Py1uQJZi7g?=
 =?us-ascii?Q?u+tHaQOeH3BRu2zG8kYuuJqZhhidTOzD34+UVtonAfaYLpov9FfgYIIKQ/k/?=
 =?us-ascii?Q?a7VRlh3Duc9fWAPMbT4AqlqNj36HgFnH4xkFlcNeLMEy5gk7NtTA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a67e9e-7cd3-4ad2-36b4-08df46653659
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:47:42.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHgJqQllY+6cLErXIzOmweuC86WYjPRiCuhKp22lCMoEPNaO037zpLGb5uOH4wC6vembGHgcVle3IfPST2rxgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035

Hi Shrikanth,

Thanks for review!

On Thu, Nov 19, 2026 at 11:40:40AM +0530, Shrikanth Hegde wrote:
> Hi Yury.
> 
> On 11/14/26 12:12 AM, Yury Norov wrote:
> > Serializing preferred mask updates still lets competing policy drivers
> > repeatedly override each other's selections.
> > 
> > Disallow multiple policy drivers running at the same time with the
> > exclusive ownership rule.
> > 
> 
> This patch should go with the write interface patch series IMHO.
> There are no new writers/governors with this series.

Maybe yes. On the other hand, the core infrastructure must provide
all the required functionality, including the claim interface, so
the drivers won't need to invent their own synchronization tricks.

Don't have strong opinion, though.

Thanks,
Yury
 
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
