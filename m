Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90021202960;
	Thu, 10 Apr 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311354; cv=fail; b=lPiQW99Ziu8bIyKuJSJjzcD/tjDHJsTXOy8F1PlE5SuYQ67nMxE1eiYuXiF7MUDaZX3O7TPYWuEYqUVlr9nUHRqu0n/Uppm4/A4krndAtY5hw5GK6NO9SpuokvChQC3N5GPZQTVAA9CRiP9lrTl3eGDdtMARFeTjcfrhKqCTrB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311354; c=relaxed/simple;
	bh=rS9ZmMuerSI+MhVuSP2mmAPI0+aUVN+muLSoqkuHyBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eoHdLEKyfACzyER+bMqH8rHKRBQA2vnjFZYYIvWEppMpk0LlS3XxVE9I0ZJA4HGSvoK6sGgOr7gyI+PBOOdvyBdD32lQvIx/4H8KoFkcl5vOcFXSdze3zDkCal+Bv/8xHPHGTIUoUDOfQu8clzQ03IfintpFr0ezs2zUEmNkphk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQ2imhgp; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQ2imhgp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AteOgqAE/6Fong1cWtxPN02TKpwk0wlAFt4TI0ELvTNMgdL57V1Ji+sLtcaYhRaX40T6m1sa6zrt1fhcTuN+v3CW1Yqxp1xILj6GehEsm8JHrJ1Mvsss1V6nQpwiTTK2YqNfA7bmMebQvYGbeBTv8/at143kYRxKAGE3Blp6/riQxb9LLK6CmBEC+2oVLa5dcCddP8h3dnWi/dIog81OYuo1OnRJi5HieIz23Raj/ch6sRTAqdFOQELKMhHjQUHDTgS3y587Sdrx6lQjOVMXZ719d9cbqzsANkUtQ5hbzI/9ZKDd5tmsh/W3thI6frcVL9m7D30Hwo4MAklfNWEJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SDy9JMmwC5qAgMvnLDvhWPIwMK/omP+tGA7llSY+7Q=;
 b=B89ZkPC3pHB0ya89kWKqd+Yy+088vshj8u3OcFAzh4qMlPBF7Of7Nu6zHg5yvASq0Nit6VSrsYZYqDtX+XGQ6y3S/Cdmi2I8PVzQ/i8jOfTlhWcz/WcebeFjV+MEUAU9I2OCxDm9dk6o+qHlF+w01tr6jt2JKtyhCaoWMf8qX9v2Hg1n9BJ5PEpjuuKYRoWJJzppcI/r0g82x6Zbd2r3SOv7oXVFGbW48iQ8ccSTVWvwedstb2+4kwsYNU2Wa+2ZDJ9U2o13Z+AMLh8dSOjuPzvQDhTOOLxBOJPxI1FKxpJnjCTVyuLuf8UZ/gLbj8CLYCRHiEfc2tHhZnOERCxoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SDy9JMmwC5qAgMvnLDvhWPIwMK/omP+tGA7llSY+7Q=;
 b=KQ2imhgpIHB2gv/gZb3pJIeaNSwEHx203xm9BeUUKW9XBhlUKuPHNArk+8xJ7HaVzB7nSzE56Nv0kMXS98pH9OXynRvc6A9wBszoBpyRocJdibZNbkSZYqzNCGlrj/UqyPmoE4kS2n64H7eJqa38HcviKSB1pI448rII5/gTnaolXEggXQkxNlQflLdUP1yYMZXcEC87JQnMz+jNDFzjU2185elsoHPOjhSIhJatriLNC1p4vqMF9oMyklhBKb2Yt09m5+2kJcvnVmz/uw6b7ZLzSX0jObRMiyYN6MQCgjfloHvVuWhi4YIOdw/b3vpP5DYRcAfzg/0VDVY/mGJnmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 18:55:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 18:55:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: nifan.cxl@gmail.com, mcgrof@kernel.org, a.manzanares@samsung.com,
 dave@stgolabs.net, akpm@linux-foundation.org, david@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, will@kernel.org,
 aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 linux-s390@vger.kernel.org, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Date: Thu, 10 Apr 2025 14:55:42 -0400
X-Mailer: MailMate (2.0r6241)
Message-ID: <A171AEEB-13A8-4A9A-A461-2B8CA098EF0F@nvidia.com>
In-Reply-To: <Z_gNBRY_1UVe2-ax@casper.infradead.org>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
 <C40778F7-6A22-4A0E-9566-9D3ACC697EA7@nvidia.com>
 <Z_gNBRY_1UVe2-ax@casper.infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:208:32d::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: d220c552-16d3-40d8-8aea-08dd78614d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLS26u+MO0A5O1HRfCZ5+iLQZ/ABzneGjRucGcD87iJY5ZDz69luCtZG1YoK?=
 =?us-ascii?Q?nIBz4jQKNsIBruDflF0rBfVGRnq8qBfjq8x0ot7PbePd9YN2mDJSAdmJFiJJ?=
 =?us-ascii?Q?fGtNru7NygfVA3C7j0pQt8XfpN/ydpePAXXCuelBNaZ0BaV52/6zTcja/qSa?=
 =?us-ascii?Q?8mKQas74wc9ne+JHWIqC33YxP+EpsMqUMFJeR/V9cVWc0nuA3GPALKrTUw1W?=
 =?us-ascii?Q?H35QtXmSlPmQLeDKwnk7YCqYGUKY6wStrTx/a8DaFLWAP/wiE/L17SNGsZxj?=
 =?us-ascii?Q?ppiRl8C9ntZOzgL8xq5+Dn9Djo6Tj+toIDmGXXBqOvfoOYa3LiP02kDAXhU0?=
 =?us-ascii?Q?f33lV7QQh+FZCNM7vIiaNAYnsXo0AX4eWB7ANya0NeG16hby3tNxhglWv5RE?=
 =?us-ascii?Q?6UVulWNnWWlidk4Cw8VtLEAsltjDOuNApVf6HvUS9gIFksRj5oZ5SefVhgGt?=
 =?us-ascii?Q?W6TwSKD1HnFjhK2nmLlleLCq5RoJPMZi4jg0ypz4VeB5ML5Kzvy4AGYwoK2L?=
 =?us-ascii?Q?/0438M/uh3ZhFWO6YVP3hc8lKycPEOgJY3PR7nfcTDdU8w9pmJ59jZ+tde1R?=
 =?us-ascii?Q?LX00ryw1H/FUvE7a32A3AHGfVP3IJkQp6CPgaxp/EbwIcfvUSljPGlUxOUQY?=
 =?us-ascii?Q?qpOWi7Ofo9d7TiHi/tW62uomn9YxpKQZFtiNTt2fXcEhFNWvNgDC/mA5txz0?=
 =?us-ascii?Q?DKQ7k33Nhhyno8YSSYyE2OGILW69HLbAPNt17V3Tim8mCiM4wqbEAYn8RGai?=
 =?us-ascii?Q?FgtcAJVZJSyD3nSsPI3mbvoyeyUK0r01ys3q+R2yvu5BM1Lq+W7Qre7tCKn7?=
 =?us-ascii?Q?tmP0SBHoRQcM3YAbAfTHr6KweazUJGJ4I32BNzxp4ck8RCc49Jfz4WyJmY9K?=
 =?us-ascii?Q?DTv1QdDPfglN9VlFZ5dWBcdbkQx3FBVIGQ8wXmDpnWV+NO+326OVISrz/4u7?=
 =?us-ascii?Q?5Sjb7wvsJHx31VhZfeSjWSmt+4LRslHakBYz6xRmU3aKD3J6AsAeg9ncvnUR?=
 =?us-ascii?Q?t1o7ripTthWH0XrwKR8ODQ8nKPng43UnMk8iChUOcJpI/q4h2wK6qFGBT2vM?=
 =?us-ascii?Q?TxhgXp3903DhvPJWnFqgya/OQAgruOQu5KcxkKGYXx/s5DD4bw01nVbmzDb+?=
 =?us-ascii?Q?ejfne1TB3pkQhLu90qKj+ckRuz2HuOu0vZJ01eLgej0yLeblHZzmkLe1FGrJ?=
 =?us-ascii?Q?dPpWAZOmoV4q/EF8vP54J7SP87S5q4abKY9FI94S1QYOqKpzL8H9aqcmQVoq?=
 =?us-ascii?Q?mXNXuOxeNqY91BcS1U3RQg6qk02Jfkw5UN3TF6UHi3pyw2Ehptcv4VwaVNjS?=
 =?us-ascii?Q?hJEZUMDE+oqfM7MJFxMINRDL4gZGPUEWeKq+AJZeWgsWUyA2xk7Zv7RUWTe8?=
 =?us-ascii?Q?QHGzX6QCph0IixZUhBmvVaYtfauTF6s9/cYuZbaYEDlH9nuxR9Dwv+rqVLL9?=
 =?us-ascii?Q?oMBwkW1wEzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mctRdzcezqthvVNdvWKCwTWtbBCcbdqjPIucqgSJQmBDxH0BbiPSXOi4lZpv?=
 =?us-ascii?Q?rTkpf691/R8G/TvUXZm9Y/3tKKnRg1CX2Xtv2DW3WzXKyMjt76OzpD6drOG+?=
 =?us-ascii?Q?bsBAxqWXdHU2etLU8ABnFvbak7trDBrFdO5HSqv/PnQxBbui+tWow0DJbeck?=
 =?us-ascii?Q?dyjvNlcp6NO2LOzT53wqjhzNKsRzjzB8P2eJ8gsmBzKibEtuc/4yE/Q1P1ZP?=
 =?us-ascii?Q?rIgE2nPin45b01PlD5U73F6P9CCLVm/iKr9H58gw7JgtoIZGRg31CmHKszkv?=
 =?us-ascii?Q?jX4INFtHpp4HXK/xGPG6TS1KwSIJTj0m6dXoVEwRIt5yG1JtOIi7VxcOrslw?=
 =?us-ascii?Q?N62ySVc07zekDt5ae6QZrfHdCp/3E8U+nSYj8kVUYRcNe+Ft6BnV1/uwIMbk?=
 =?us-ascii?Q?q9F4biA1IbaTqWSlOHcMKH8MVJChOifJrTaAyFPwmfG1lt/Dd4d2aX+a9Ebr?=
 =?us-ascii?Q?swoujYkQJ5WVLSbX//wkLlYpgMX6lmPX9vpnM6YuM1JJxxapxM6yJCOG96C1?=
 =?us-ascii?Q?KmXqir1pYLT3hQDvf/neoNVS5dVj0TLNXJpuHO+3/ooTEaH8Skrdc+FXQo1a?=
 =?us-ascii?Q?PBvPE3dkjPnXB6Gpx6eVYZOGBD8ryWzUvjq3vObx5i8VipVo+viZ1+COEA1A?=
 =?us-ascii?Q?n+QBgd7yoKbi3NGca9EYev+tsKtBPBhXPVSMdNNm3gbi9RN2U9vze/62VQ2R?=
 =?us-ascii?Q?c1NZ9umUIYhfg7iHtWi3FUS8ku2w1T79+ZklffdEE8Q8lYgDB3wOgoi4Knql?=
 =?us-ascii?Q?w8F0kniSvq3MLXJebNov2dzqUiFdVIEU/VOAIurVvdQXBc+Pc6gngRZDxaSF?=
 =?us-ascii?Q?5XuzWaPI6NrW+n+R/b8fdA61To7AE4WMqdj41A/MRRN926i1F5x0L+U9DNZ7?=
 =?us-ascii?Q?cYaw32TeSDa2J5W72yisM1gKly+DrXA48h8x2BSfOh92eGP6O+Ihw/yZS5DS?=
 =?us-ascii?Q?mLJfW2oBup4+1yhE2qpaRvcJOTiITmdXKJfqeWHtdIA2zN/S3AyQPHRUbyE+?=
 =?us-ascii?Q?c7cgTR0ffOKTPhkR+He8d4gUA62qdS5nbT/yu0jveOYJ5I0AlRGaMH6o34wZ?=
 =?us-ascii?Q?v3zymKNdarLxOw7PlGDEgQGqX9pqt9VMs+St08hzUeFRdb/MFrm64C3YYZRY?=
 =?us-ascii?Q?0b49rHJsqdY2GvxYnRW/ZrLdC9lo6Y6occp1G/v1RQU/bL/rp8tdpIGQ1VYQ?=
 =?us-ascii?Q?KbTI/r69JrkRJtTAiJrFQOAFip5i463hZYEwkuFSiV18KCIi5P1Wwv0fZYpW?=
 =?us-ascii?Q?84b8xHWclxzV1KJDRw+48Jc+CfTf/xPA0WgxihtbLL8Fxn58qb6we/vIAaUI?=
 =?us-ascii?Q?iPR18cUUJLDqeQq8htjbakKJOVHQ3gI+qW2ZJaB+trJp2O1InL+oeKxv7tkK?=
 =?us-ascii?Q?dYNSDT5V2CTO6rFT+hv9WzBDvr/wwqw/HaTrv7RYUPXkZ0cyrwBReWUbvUbI?=
 =?us-ascii?Q?RKf56aFhLwvDHRmXUyjqGXl435VsswQr4/MGunropCKDxWOfTOuWmy131TJ3?=
 =?us-ascii?Q?DdlWPThrrcYv00cewZqkVRdOWRl5GcXOLvtfJTdSkQXFvum86Qbqjoyn6r2Y?=
 =?us-ascii?Q?kkPB63h3zkOpkBuj5xpJup6cymQJM06V+JWvZEUX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d220c552-16d3-40d8-8aea-08dd78614d19
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:55:45.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wefknkuw0FbDMrWhtDzQuu6nc0PMtjW4MIkWTSMR6venLHmSdEkeGLzQrKghYwFP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437

On 10 Apr 2025, at 14:25, Matthew Wilcox wrote:

> On Thu, Apr 10, 2025 at 02:16:09PM -0400, Zi Yan wrote:
>>> @@ -49,7 +49,7 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>>>  {
>>>  	VM_WARN_ON_ONCE(delay_rmap);
>>>
>>> -	free_page_and_swap_cache(page);
>>> +	free_folio_and_swap_cache(page_folio(page));
>>>  	return false;
>>>  }
>>
>> __tlb_remove_page_size() is ruining the fun of the conversion. But it will be
>> converted to use folio eventually.
>
> Well, hm, I'm not sure.  I haven't looked into this in detail.
> We have a __tlb_remove_folio_pages() which removes N pages but they must
> all be within the same folio:
>
>         VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
>
> but would we be better off just passing in the folio which contains the
> page and always flush all pages in the folio?  It'd certainly simplify
> the "encoded pages" stuff since we'd no longer need to pass (page,
> length) tuples.  But then, what happens if the folio is split between
> being added to the batch and the flush actually happening?

Apparently I did not read enough context before made the comment.

__tlb_remove_page_size() is used to check if tlb flush is need by
tlb_remove_page_size(), which is used for zap PMDs and PUDs,
whereas __tlb_remove_folio_pages() is used to check tlb flush needs for
zap PTEs, including single page folio and multiple pages in a folio.
On x86, __tlb_remove_page_size() and __tlb_remove_folio_pages()
use the same backend __tlb_remove_folio_pages_size(), but on s390
they are different.

Like you said, if a folio is split between it is added and flushed,
a flush-folio-as-a-whole function would miss part of the original
folio. Unless a pin is added to avoid that, but that sounds stupid.
Probably we will have to live with this per-page flush thing.

Best Regards,
Yan, Zi
