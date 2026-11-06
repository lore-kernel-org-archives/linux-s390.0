Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986456;
	b=qot8CszaBNPvHrFayNBj9EUka6VKZIWwaHCdO4PuvsqVtwTLSKDrlsKeT667tzFm+xcj
	 qXPG7LT/+V9e31M8DP/NnQgd/TX78hsZmQ8OmbKGaEO7seFwehTVPB0Uih8Tf/UaM79if
	 jhSxoZGyIPy2rNvscEPAZLG98lCPxqdkDe287LDNS5z82QgLpYVFNHCG3XZtrnO2W/fVa
	 bJOZxGlZG+eNR6leTtPDdtBYUR8hJJsnkk7CSmHEkynWReTl+rEPKbYXoAEcnAlDrYWq+
	 91zOYDlAGQ3NIG50BD3Xq/fpPPeWVq9TXsIVM0DM2wMx6mzVK5PUh2KI6xBs0TTiZqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986456;
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
	bh=zr5EsqAeRgl0PR9xLhThn3KngTsDBbfz9y5uLfr1pNs=;
	b=5NtY4ELB3fogPzMznHn3xFJ/Tx4XR27ffUn+B4Jj09WE9sLW+KW76ZxA/AqL87nyec6n
	 KqCOaedrE6JwrevBGktYS+eoqBNj62BSKwWRgvOPFge8DxN0wGDgOwIZ5r8ksrCvxK5Oe
	 A5uaFwMusHDVuFK6LPyh+YU4PnO/mjtQHhJ0A4m4o79ikLYuYISahG2N5vb0lINem4hXZ
	 E6ac5MCs0FlNEHnpiTTCK9bnp+6TwAXPQRSSbV0T62Ugv569ISsN6tnGIGn6pnwdQP8vZ
	 FHjKN4dlat9C05qMfk0AupKpSge9HHVXdbn9QHq0Sni52OCzewtMGVFNnPgG3/G2UYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XwCHydSH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C2606A329;
	Fri,  6 Nov 2026 17:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B96C2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XwCHydSH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycKSAJeI5GGMKL3yd0cgX04/QYJddRke7vGmbgNkOSDoYmozTHWhldvu/egiZRIdmJmFAZSNUE7O4ElSkbnfkOjHs5MdKMYj5dj+FLqmycb4/IQeQxwpFp3ULes2xUrd4iLFnARQETcFP3jcaz9DqD9nIVTn3ebvTX+avWUI9WCVeyjSgzyvgomhfACqO8Bxq3Dj7aC5htJ5wM/M7aT3qrd0a1Lb7mq/ilqXLp7IJPCYlfGue2xXN/xFyi2W6hhgZoTmC190DSW3fLdXDmCME87UfzAvo1IEGSNXjrBMAJyMQ8Iz6kPpeoYn+OlY+LdMX1ohe7cBLB/kwwJQgLudCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr5EsqAeRgl0PR9xLhThn3KngTsDBbfz9y5uLfr1pNs=;
 b=jWsnaiMoX4I2VWnxw5z8fWFhKUVWGhONz8W0iEcjcnqrz8RFfZSqiyqyfYOp+O1x3We/LbHtJkxaNHovcUw+Arh1+Hj7NQacN0uIy1RxL6OZh+NFL+LWuqN39H686OIFy0EuMQP3YGHqUI2WLetP69cCimBI7CFEJustrUgeAfjUbFi5e7g3J7kG+qtbWg5Icr/86OCEKLirEJnVjVmlvdAyOCVgRwqNnNRcAhghgQhkZ1aBEhdiuo0T8kzPRiIqNe2v37RJZRbtfjn0t8JS04eiaSh46Iaw9RO0fz4etvJfWq33TJ+14y/AMI52a3clJ3UNYNFSYAQqS/u6OMaDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr5EsqAeRgl0PR9xLhThn3KngTsDBbfz9y5uLfr1pNs=;
 b=XwCHydSHGe0jOlEoJ2oXmByZC2WOWAeI2qjpxmBLRZvHmJnlczajMZR0yjeRoW7xIM2AbXBaEaqAl7eJTd1TysVcuA4kVEH8Hj40aw9xWIgq6jxCu5hR2EJSq6lvZ5gVNbSns1y3RaE3JCgMCBk1sYzprxd8FpRhrUHwDyEMW5M3YGJa0ZK01s8+yWuThosYImjKRFSLNmmxBcAuvp8tJnrvQLz+Nvj6V2Zafk/Da4a+9uKtKP4v6k0N5y6ZVg3bQy85f4YZnJxCcGZnhCOCFsqotwCtJlVOhsPAsNopj/mtKANeepR2n1JEq34dvNpnSKYuszHJ8f7x4y07frIfEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by AT6PR12MB717548.namprd12.prod.outlook.com (2603:10b6:170:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:34:11 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 17:34:10 +0000
Date: Fri, 6 Nov 2026 12:34:07 -0500
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
	Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
Message-ID: <au4PfYJkpKLsISqb@yury>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261102084704.GQ1779021@noisy.programming.kicks-ass.net>
 <auoQfjpg3CRvV5yG@yury>
 <20261105145537.GP1813469@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105145537.GP1813469@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BN9PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:408:f5::31) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|AT6PR12MB717548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8577c57b-a7b3-496e-7021-08df3c2c2ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|10070799003|366016|22082099003|18002099003|6133799003|10067099003|5023799004|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261022115727099003|261021135927099003|261021121427099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Bk6udFt41qfC9pkfEJd/qLNkQcpM7qRlAqsbAGheitOsEbIgsFGrh+24CoaJsOB+gMkvuFrC7YPX/RmVcyc/aYNsSA4nypAvrTY/pclT/kOtLufNoYGruaLnfSihNXHyBqQEi4KHnpqrEWhMX3SASHR5HNatCci2cJBMoOpNx9aoF9gaRHo8V9HYJadYx7BNDNRuBzSOXFAr1SGZ1kIjvte6oeiYMZl2Vr1nBQpW6RhRSktACz/fmHNPJXeoG9IH+eDI8nj8/DasWYSzW29M9JzUYldERsYqDbgf0o7auMWnDxDVfKBBjAvyBLJeVnahiClQPpNVweryCH/kBcePFZRffCD4Prv9FPemstx2bMtHylNAUVamsoegVBFhrJkpAi4FQoHJv//UI/BDbw2vHnibigi53UN5+zql2lulXVp/ZS3TpGXmrQvzdUiXU+BIv8qjgqqXlrCX48OWiGfpttK0HifkIgbIiVtn869f+WNirCbIm3mdMpaQXkrDzJWIDG38qwJDEeYRpQT3YPXGdkMr3SFguHy+9LYanb6UrLOr8g6npCtdDKaCF+mZ8HQ2fat+7AauklVXwb6+H48vW5SI9uB4OHrQz6cJ/4w8wON5mIRHKadYSgCTY0lF3CH/GGQR7Bp5hrWRh7plEI74/NVKrkwCFzZBdwQKYjhr8MA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(10070799003)(366016)(22082099003)(18002099003)(6133799003)(10067099003)(5023799004)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261022115727099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONj6MYRNU5GeOK5xNGOR8syM0nxEh3ZQ7Vmv/z79sFfpwc5fD7w2mAEIrvOS?=
 =?us-ascii?Q?y1VsgfHdu1MhYz2sFvBd9ScybniN20gu2+c/lvkQKNBZ2O7UrwZXqLc4DmQG?=
 =?us-ascii?Q?pzjcR6ePV4PA6lUbUf0ioYPvlQc3vusfNZIxQind4BLV6X9sysSVoywseAWb?=
 =?us-ascii?Q?5/rovejGWgknz2PFH+Id9nXsPBc5aZCbpk/Y1czY9PwMENRvu4T6wWYTUe4m?=
 =?us-ascii?Q?g7DzPXVWfhuuHP6DgKXJIR476pbkCJS+Qpm03/GyVVhMv5WmjwqSS8WEWO7u?=
 =?us-ascii?Q?2k8Wn63m9FfpXSMFLbBahCbSU35d7gueQ/wXtQv/ZTENn/r72K64NoZzHYXs?=
 =?us-ascii?Q?z9jIcaotVXSkvqW1gggzK7H/Fa9XDYbxhxNCBGC95cS4eIC7B6lj+Gi/CWUJ?=
 =?us-ascii?Q?Tx6RU31lkS+Fu5cEvhEhwhyPjyjaif8l3/MH+PrKECQMfV9LbrAMmCHNr5D2?=
 =?us-ascii?Q?Zw/Q++fkhWLy7WrVCtXG+/bttsudxzt5vrKmySfiJpeixBjcETOrnUHjrqKi?=
 =?us-ascii?Q?kUrP1gE1Ws6vEzH+k5g6xXr29pQhAsOb8X13FkGMXxBVT41ov1ZIHxcU/9Zo?=
 =?us-ascii?Q?wyME82/RY/Y6qFr/en3VViBUcU1eBMjJ18J6Cdrc6OASR0hICXA5xZTRCJBp?=
 =?us-ascii?Q?bek/7zSXBlgFNRheVMur37ny3DW81FxlaZSQ8DbrvSDCjN8X24IQftpbJehv?=
 =?us-ascii?Q?3FwxLNuyLHn7T4ROicD0PCVBHTLnvwnnS1/VOKFmw2+XWXUwdCDzsCjhxXUi?=
 =?us-ascii?Q?fzn+xURPr7ZL3AsWUjrqBpeCw/S0PxWFIzVehxZO3i2AHH6rJuN5vh1GrZxn?=
 =?us-ascii?Q?RTR/aIaczAji0daVYgyMfFw0n5/wOlrJ20f0iQuzhv98IaZ0TgvQ+kCnOS6V?=
 =?us-ascii?Q?QKz4W3YrIbMlG4/xeEv7nsJxKlMJ/JWb3rnGtZJkqWAYBn9+aQvqQPSpBc0C?=
 =?us-ascii?Q?Q+U99D/ctbKd77jCDcBu1W8gHQZA+zfClELG2Eox8r9dGk0H44dxabylIRXK?=
 =?us-ascii?Q?fG6x0zYZdQ3YyiAPh617hbeapKEmdWrqxzcdyUXlgWkY4BFQC+Uuuk3Hnxx9?=
 =?us-ascii?Q?IJrrZ9RJKh/YdkRS4X3fYkfBMuJYPvLlpuppiJ9APVmZvFDOaTplnWgdvyEc?=
 =?us-ascii?Q?lABghcdU9WSI7o3yonGHlTNpS4L0tBCG/gHIvJFeorQ3vXlGcOkvsBIbEgdP?=
 =?us-ascii?Q?kYmjcWY5UUCyai8h7y66VkOa1+TF12X7SK1q6ZriVo6fBwc69iVa2i/xqfw6?=
 =?us-ascii?Q?+1PEdSKqfKo8VY4yKmU6nLkFDs17M730N3jOt0enjBtyu8LWPXD4/git2MsB?=
 =?us-ascii?Q?zAUOEeyKitk1paTqQOawvuyreLZeKqPt4stzleZz6cJC2KF1XJ3o3alnpyhJ?=
 =?us-ascii?Q?fzXb2hETafge+gC9rtp7zeKo+IAIKr9fmWPb9A1fPzq7ylxTWqMq8Xmupx0m?=
 =?us-ascii?Q?HGC6Q2TNiLyBr4CLnkUmn6V5V7cRLmNIlwEUrbja+MZ5ED0S90KHembQuDuP?=
 =?us-ascii?Q?B05C/626b5IRIMLxf9SFW0Hb02MfmdFlBx+ISnHRtGtuKaaB0q4WZO/4Bmul?=
 =?us-ascii?Q?pjujw4ln5qK1+uIp6dikWRT/PiNfSwc50mysu+Dc5qZxHwC8EMswxVWuIkEw?=
 =?us-ascii?Q?mGfwB2VPoPKeL0MtnAXPz/DMbWwTUMD+BN4iguypTMXWjuMJSC00NAQJJzly?=
 =?us-ascii?Q?p3qppgJutPvELnuuvpiEcrh8h0g9kOogA9tBKmq9uYihPyJkLu+73+Ov6O1i?=
 =?us-ascii?Q?0u3Y19PARg2noG8yjuAYhaJNxYiPO/SmwyOJHln8tUcbkjfIQv54?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8577c57b-a7b3-496e-7021-08df3c2c2ade
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:34:10.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /k2FgHNyjlUeWvVm7jF+9eOK69UBPvKyUktiF6XS/mC7vvVJTpFTLWOHL5KvDvxFETA1rSLWDuNyX/dPm9riuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB717548

On Thu, Nov 05, 2026 at 03:55:37PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 03, 2026 at 11:49:02AM -0500, Yury Norov wrote:
> > On Mon, Nov 02, 2026 at 09:47:04AM +0100, Peter Zijlstra wrote:
> > > On Sun, Nov 01, 2026 at 02:21:56PM -0500, Yury Norov wrote:
> > > > The preferred CPU mask currently lets the steal governor reduce vCPU
> > > > demand when physical CPUs are contended. This series adds manual control,
> > > > opening more use cases.
> > > 
> > > Sceptical, I am.
> > > 
> > > > For example, setting CPUs aside for selected fair tasks at runtime while
> > > > steering other fair tasks toward the remaining CPUs.
> > > 
> > > That's exactly the kind of nonsense we don't need and makes me want to
> > > stop reading right here.
> > 
> > OK, I started with the wrong argument. Please consider this as the argument
> > #3.
> > 
> > #1 is: conceptually, preferred cpumask improves performance because it
> > moves the scheduling decision from host to the guest level. The guest
> > can do it better because it knows more about the workload. But then we'd
> > consider moving steal governor logic to the guest userspace, because it
> > knows the nature of user workload even more.
> 
> I am confused; it is a simple control loop and has nothing to do with
> guest workload.
> 
> The host is over-committed, this results in vcpu steal time. The guests
> observe steal time and reduce vcpu utilization.
> 
> It is a co-operative scheme; a bad actor can game the system. It is
> imperative all guests behave the same or do not play at all.
> 
> If there is no level of trust (our coconut friends) do not use this.

That is correct. I'm just trying to let trusted userspace to be able to
make a final decision, not to cheat the policy.

I believe that the preferred cpumask approach may find more use cases
than just a blind vCPU throttling.

Even in case of throttling, the userspace might know more about the
nature of external pressure, workload and VM priorities, etc., so be
able to make a better decision on the preferred vCPU candidates,
beyond the steal time accounting.

I can imagine a host running two VMs - one for performance critical
workload like AI training, and another for latency critical inference. 
In case of vCPU overcommitment, symmetrical throttling of both VMs
may substantially affect user experience. The better solution would be
allowing both VMs to communicate to each other and decide how many
vCPUs should become non-preferred on each side.

Steal governor is a reasonable default approach to the vCPU overcommit
problem. But I also want to be able to adjust it to my local needs, if
I have to.
 
> > #2: convenience and scope. Some systems don't allow loading modules -
> > either on config level, through selinux, or somehow else. They don't
> > even have compiler installed sometimes. 
> 
> You hurt if you shoot your foot off; not my problem. If you run guests
> like that you don't use this.

I don't configure systems that way - I only request shared access to the
particular hardware, i.e. to run some tests, often for just a few hours.
Sometimes those machines don't allow loading modules, sometimes it takes
few iterations to reach to admins and ask them to update drivers...

> > > we already have cpusets that is more than capable of doing this.
> > 
> > Then why do we need the steal governor at all? We can steer all
> > processes away from a given vCPU without any driver, only by playing
> > with each individual process' affinity. For vCPU throttling, task
> > isolation, or whatever purpose.
> 
> Different level of operation; different semantics. Cpusets is for strong
> bounds on your own workloads, this preferred mask is weak bounds on the
> system due to outside pressure.
> 
> In a way it isn't much different from ACPI idle injection.

The idle-injection indeed has userspace interface. Powerclamp exposes
its actuator through /sys/class/thermal/cooling_deviceXX, and documents
userspace control loop.

By the way, preferred CPUs approach may prepend hotplug in the overheat
defense chain, as a cheap but weaker alternative.

Thanks,
Yury
