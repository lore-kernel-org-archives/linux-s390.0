Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795364484;
	b=G7R+g/HWl2hdKFtm/KWqIu+cFBCfVZ0xt0tm7nNQfTP+52n9Y4OEyEJm5tUScdy5WD2G
	 Frvj1U0JfWcfuZUbBUZWJ9u46bnPs81P9nB/d5dZ2TCnjwoRBTopRaKYxz5eK2dR0mYVL
	 n758TNit+fIGQO6kYvpx5zp1ha4VpfSFQFcPm+lPbVIClPQ/BbagUN3891HBScaofceQY
	 Xs4M/VRHwaHOZd7lBP1/39NKnpWkZpzz8TfqtFKsENCygoUIK/Zbs9quFx3st8aDfJiN/
	 3GjAdaX0NRqnaGZpHKjWL6nWLUuMnzn+ZJnQwCVfMyqoazGv4qtyWehxlq4pOxRnRfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364484;
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
	bh=GfAeIpJA61xn+LTAk9mD/MTo0a9U9KRLHEtUWSnVr64=;
	b=HvZ/0Ty6BEDcZ6txVa9DTWjK70kkJJ640dkLwGq1LFLtp4fkKDO1rdZaEwsoWrc35yEk
	 kYs9zUL1bA15N67zD7TYf8VyuOWq13PMbnVM/hLnp38/ICATH3y7pjmX+04maYfE1ijiP
	 iwPZt2jghJlwKEe1s3MXuieuW7uYHckludh+sumfbxYYaFCYSg4zJmca5ueGn0KRCZIJY
	 l3hGMZ7l1DVSMqMITM/8j5wW8fZTaDMd/GLWbaZBX0qCWXF0lP6zYLW9jt7ZERbqCI6QP
	 ZUfyGA7KdkrLVPNK98mKdgOxB4U8pfu2+36vhjnjsncrj+fWPD9eFW9ll+MalLWP+Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uprtXWXw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.54
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D2606A330;
	Sun, 22 Nov 2026 16:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B30D2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uprtXWXw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE5xQkrUcQQMGvHUm+Fswys1bq4F8I56eussTloKGSi6O2pJZlSMC59XZxelZw1E7+22M2NOgl0EVJ37fSKg0JqRbdISpf5c4/ClQH6WeLZQGsAX1ukrMW/XNF/0OpyYNxUezWpK6qfB3X5DDD10P/QsncIqnaUXM45rGAaj/Jc++99aBYhAHoh7DLsu0mhtaa+38UZRrjzMOc96SD7Izu+h0BX8nLwTCAy877p7QYQA29VQUNs5qiEWp/Nc+wsPv4mHMqOFWgEQV5M626gr7y89LR+R8t2QjbhZSVekhxho7/Bk5oZW65dZA0/v/hjOXN6hLvBPONIFRShpUSn1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfAeIpJA61xn+LTAk9mD/MTo0a9U9KRLHEtUWSnVr64=;
 b=cH5YTL5S0o4Ruw6I98IkEJ25oOG96CA6uUckn2KFPy5XuBCDNnATWPDWeINM8L+ln7NOHqcLRoZYCZS2V1OAsbV4KrCwoXTTccccm9azbNkRXuje5OgMMbdsRXutZg1GNdDnZ/YBWdpHZ5V1+pNyiaJh8OpTIm7OYP8X5lkT938Fp5MfCmAMUSqt+6tEW9q73I6vlOdyDfOIfhSjvwyOZYQWJG7V/lB7sa69ZtZrVer0kSPFlClJZzJsjs054YVVbVBrpUT/TTbD2qixqk99mtw7+/lB+gBxRkleLzOpNPgWZaZbdYYoUtEDFwhsN6Fx2OUdg5r8SF4JkSHc88Whsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfAeIpJA61xn+LTAk9mD/MTo0a9U9KRLHEtUWSnVr64=;
 b=uprtXWXwfDGQFVx7xMiZ3UJH2ZSoEkg6YVMY1R2b22+em7n5afaF3wGYzR4ETHvQUgTc5idX8bE+/ebYMQhUYt3w3QCuwwxIybK9Iq+pDZCtKv07O0MJnfzuQ12X7jFCPG9MnaJDFPzk2QZtTfHo72LSSHA+6MtGmFbKEp7NlvfJJA4tGtQyQXxitkkFr1TzKLyA67wJPFLnfzEFV7ZMX2VYWherQXjH4MRgufJLLTFn7zJpwiT4RIHE8AUtksGn5+GrGG+vWUfP5spuofI/LkUPlYg40f/AK5YYs7ily0UBvzS/lETSN0FZALSbH2M7V4E9ci49wquMEMPnBWanyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 16:17:02 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 16:17:02 +0000
Date: Sun, 22 Nov 2026 11:17:00 -0500
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
Subject: Re: [PATCH 4/7] virt: steal_governor: serialize sampling against CPU
 hotplug
Message-ID: <awMVfJhfmdOXUDZP@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-5-ynorov@nvidia.com>
 <1556d3b0-1c89-4d3d-b9e5-5921c5c9158b@linux.ibm.com>
 <av8oy9v9eLTL0dw8@yury>
 <38f8999a-f3e1-486f-870b-25710462308e@linux.ibm.com>
 <awBopXdhgUatAU9d@yury>
 <4061adb8-0f62-4630-87bf-dc7598ac18e0@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4061adb8-0f62-4630-87bf-dc7598ac18e0@linux.ibm.com>
X-ClientProxiedBy: BN9PR03CA0395.namprd03.prod.outlook.com
 (2603:10b6:408:111::10) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b342b9e-c467-4578-350a-08df48b40a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261028144727099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0MSsL9sRpyob+bN/+WGpPLbyS6JJyfDITIkXecxSFS4L0Bxe914cnIkuK0UIGQNNLf0YsXe8pHARK4NeQoS90dZWhDZaBj18ptPTRMWZ3rKmB3BxJ0JtWFccDyAtWn7BXhVgS9xGo4ELtpsCIAOv3/f8RIiOZCrS586ehgVrkofU5JQQqkSCYRC+lmHq90TGlQEx1+hf61QGbUePl+KDyrnl5VhyDf471WMuuEaQ+7DV7dC1r4N4cxzg9nF1zLUVYBTEMHurBcjC3vRZZqewwB/ZHiTCzcHFeCMEkhVMPhLIdHny6jHMfu1TbjViinxHC4kx2kGJ7/oQfOi0Jl2KpnWJc9Qtg00kzGuabFH6yRQk+n1iFYJLYazjeVdAd/oGYD3yCYlgxwT+stBCF6TmoPl7utZryG66vYY7ylDH+bXfaSVWf2USxWTif2lbFl1Op04KQEFxIaOAknSGHaPiqgGQemhhfeVtw8MUJHV+lkDd+vwn/TIqujg5GlUilT+UbYsH/14mVEj42xnhxw7aEvNdT9VWLr3XE6YLMknVE3wkx6T1E8j2FVSd76ABUF+xkby63PiJc4qGjhERDUOgHcd/uZ+S9ioqOEEYsZ4m6ulSIyllK/Ev8EqQvH8CwbCMeHxm1OX3uJYVBDlUDxdGHX5ICoILyomCB70X4j1PeWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/fMlSh/N/D5hd2sja5tBX8qxhWLHwwXiUWOvAtkbZZ0+tFj0r6OJuQJzMjyY?=
 =?us-ascii?Q?hL1l0cNQ/4FEply1/mWlpfYNOfGMsdySjLQIP583yjOrnrOFJQIs7N8+mF9h?=
 =?us-ascii?Q?4BqkhdKg1gJ5G2r3DRdvlBQrnY6/tWaDryykpf9Y2vPmafy7gbx9qUDlK76f?=
 =?us-ascii?Q?Vhf2C6OOY89VRW7LcpZwGq1SStUn/SsTtqFqUqhA+RXUcPlFiYHp9IDG3zsd?=
 =?us-ascii?Q?pBdjKXTMiES/bMb3mATGLv5dn0pHp3ECMNYCZVZe8lIGLz6pOM8vFgyaRmkI?=
 =?us-ascii?Q?l7sR46c6tmJnPZ8fKT7aJwpVON7JHQqoV01fcWWbASKyxrwfdUDh7An6XApg?=
 =?us-ascii?Q?x7pumkG1tusC/stoiJSEDUpizboBSSbxcsY1nxKkJjWGtKkji0fz3MROx0+V?=
 =?us-ascii?Q?RdAa9QiiP/8Hv/DuNC9QSvYDMtz68w3dhi68LQzKX3R33AiSc9qUxGLnx947?=
 =?us-ascii?Q?PW6iqGXCZ+yuwAsaa1Ju4teuXECyVt2yol7eW+gDQOkBLJgLUKeEdaYVdADb?=
 =?us-ascii?Q?etQyk86e44n2nckl1zyzOsbTnNouODmJM/6DsfwckFmQuoBAjoRRip4k0Ln5?=
 =?us-ascii?Q?aWHnFkStmxFLj7IoDtDW5SVSLfHA5QukxRXJ4HWYOfLFeRY+RoJILSRLvbWK?=
 =?us-ascii?Q?xlew8YrfI4C3sKM3Ta9HGPJIwYfH8qaxQ++l0b0zAQYONH+/sIjI+aLpxfKJ?=
 =?us-ascii?Q?xmbZl4qG88lP7iSE3S422xaRzM6IaDeFmjXpDHN1kcODwjJgruSei4i1g0tp?=
 =?us-ascii?Q?qay/pfg+YFhSh15uixRyaxuT92Lq/qa2hq7ZfJcF5Gd9tqzJ0nm7WuEQPXnI?=
 =?us-ascii?Q?71ncMfMxaJD0ptcAav2ux/bIjU3CjXzquuAoAFFXDMN9GsHGM0HkxVHguNJs?=
 =?us-ascii?Q?UyT0/xx2dPOHbathxt0m7+CS3js7TSOKEPeyJA8RJIzo6O1o4S3faT0nJI4b?=
 =?us-ascii?Q?4QduAW4opgiThHUEXsTgY+QiRw31vQQXtnjCyCmoWaJQ4WMvzSpMPZnpPKlE?=
 =?us-ascii?Q?aV4crPvNfoD78bDmkuA8G/tj3TibyYBnJ3aJZ9P0NzqQFFX5jQwQTCokM5jp?=
 =?us-ascii?Q?1RqJTIuqgt0/QsYUdF5N9c37ZMJvLerUP8L2bLaJ8pNW51jqtlGfdLeO6TtV?=
 =?us-ascii?Q?axlwn0ThcHl0LnhkDGvark+sXMnwlyK5vLosrhRdExpaE6oYERIAeGwagrFh?=
 =?us-ascii?Q?S+Bgq/WNRMDmMEVOKcFJpwWKnM1/CEMQdgaKD0/tWua7LEAenEZhK8LxBZpn?=
 =?us-ascii?Q?sIEh13Qymd9PfxKihmLDfvtg4hYzQ5opUJYFyAbi288AWGT0HgLjAZ8wuO3D?=
 =?us-ascii?Q?gZy3N/TMGIjz5+WMtGgBt7pd2ylI27sLuUNLPLvWsdpTxaZFqve1u81HJHs1?=
 =?us-ascii?Q?UJ06kEaTtSazNMoKmAoxqwB7I1mZRTeapc3RJyX0/j1nROkQNUM3KRsLFnwG?=
 =?us-ascii?Q?zcoeOZQPqCmRG0vC/RpocO/5P1DDEc1nih0CBu/1EgiRoWqibXcgyWVJXnrj?=
 =?us-ascii?Q?bX8mpimnKfSrnyedlmFO7bjstPmJ0y1aGF0GfRDhP7DxcC/S9qKPk6Q4OA8R?=
 =?us-ascii?Q?Fddr7Snk0+T93iayOgNAXO95oHvkFfq8LlqSZaGAX8TjP7p+K0n7gZG6QSfn?=
 =?us-ascii?Q?b8O2CoT1oGeckf5rnu986buuIFJKLDA5jvIc/Lw6ZMyRfqn9MiYgnvwOzCPM?=
 =?us-ascii?Q?FmzzW1kWEFq43fpakV4tKJvBn26eqCcXRFEVbGoyBkDZppDwubsoqjw0BuBh?=
 =?us-ascii?Q?ce2SOdMB9V1lRnwfYtAWbUQFgdWKdHSAWbiG2F+4/rt2CcmHu2VO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b342b9e-c467-4578-350a-08df48b40a81
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 16:17:02.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfm55TNhTVfDYX8rQL7fG9M2QSSOaX1Mbdw0AG1I5BbJNhAJP5ujAAAIyf+MPXEAYKLzJHkddglo6Jnixy+N1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On Sun, Nov 22, 2026 at 09:24:09PM +0530, Shrikanth Hegde wrote:
> Hi Yury,
> 
> On 11/20/26 9:05 PM, Yury Norov wrote:
> > On Fri, Nov 20, 2026 at 02:08:59PM +0530, Shrikanth Hegde wrote:
> > > 
> > > 
> > > On 11/19/26 10:20 PM, Yury Norov wrote:
> > > > On Thu, Nov 19, 2026 at 11:52:19AM +0530, Shrikanth Hegde wrote:
> > > > > 
> > > > > 
> > > > > On 11/14/26 12:12 AM, Yury Norov wrote:
> > > > > > Steal governor is not safe against a concurrent CPU hotplug operation
> > > > > > because it can change active and preferred cpumasks during the governor
> > > > > > sampling.
> > > > > > 
> > > > > > To address the race, the governor would take the cpus_write_lock(). But
> > > > > > that may be impractical for the loadable module.
> > > > > > 
> > > > > > Instead, implement the following locking policy:
> > > > > > 
> > > > > >     - if the code takes cpus_write_lock(), it's enough to write-access
> > > > > >       the preferred cpumask;
> > > > > >     - if the code takes cpus_read_lock(), it must also take
> > > > > >       cpu_preferred_mutex in order to modify the preferred mask.
> > > > > > 
> > > > > > The core scheduler and hotplug paths already modify the preferred cpumask
> > > > > > under the cpus_write_lock(), so no change in core logic is required.
> > > > > > 
> > > > > > This provides a common update protocol for multiple policy drivers
> > > > > > without requiring writers to take the broader CPU hotplug write lock.
> > > > > > 
> > > > > 
> > > > > This is also necessary if there are multiple writers outside of core hotplug No?
> > > > > So should it go with the write interface series?
> > > > 
> > > > The race is real, and it's already there, so this is the fix for an
> > > > existing functionality.
> > > 
> > > At current, if there is hotplug, core takes cpus_write_lock to modify
> > > active/preferred which makes governor to wait.
> > > 
> > > If the governor is modifying the preferred mask it is taking the read lock
> > > which makes the hotplug core to wait before modifying active/preferred masks.
> > > 
> > > And there are no other infra modifying the preferred mask.
> > > Could you please explain where is race currently?
> > 
> > Initially, both masks contain CPUs {0,1}. No cpus_read_lock() held.
> > Steal ratio is within thresholds, so neither update helper runs.
> > 
> > Governor worker                         CPU hotplug
> > ---------------                         -----------
> > preferred_cpus_valid():
> >    cpumask_empty(cpu_preferred_mask)
> >      -> false
> > 
> >    cpumask_subset(cpu_preferred_mask,
> >                   cpu_active_mask):
> >      load preferred word -> {0,1}
> > 
> >                                          cpus_write_lock()
> >                                          sched_cpu_deactivate(1):
> >                                            set_cpu_preferred(1, false)
> >                                            /* preferred={0} */
> >                                            set_cpu_active(1, false)
> >                                            /* active={0} */
> >                                          cpus_write_unlock()
> > 
> >      load active word -> {0}
> >      /* {0,1} is not a subset of {0} */
> >      return false
> > 
> > /* Useless and misleading */
> > restore_preferred_to_active();
> > 
> > /* Skips schedule_delayed_work(). */
> > return
> 
> To address this, then we need only this right?
> 
> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index 81e5089ba824..6a49ca55fc57 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
> @@ -202,6 +202,7 @@ static void increase_preferred_cpus(void)
>  static bool preferred_cpus_valid(void)
>  {
> +       guard(cpus_read_lock)();
>         if (cpumask_empty(cpu_preferred_mask)) {
>                 pr_err("empty preferred mask. stopping\n");
>                 return false;

I just show you the race I've seen. The root problem is that the
governor loop is not protected itself. Even if you make each function
within the loop protected, it doesn't protect it as a whole.
