Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED03C04A6A
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jul 2023 07:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGYHfH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jul 2023 03:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGYHeN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Jul 2023 03:34:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2091.outbound.protection.outlook.com [40.107.212.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6431FE5;
        Tue, 25 Jul 2023 00:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAvhXLx5yuzlCA2Oi4n50dcM0Ousl/2uaqSwYHDPljdeiExIOVv+sfAfFoYZrP9W903FUX3Y7ZhRcTOPEvq1+S86X03p69Eie+VIygwgCXulR5Nkq/pKnSEf2O1kAZUz7olNCZg7mwsjsivaTBtpVfwh7Lvd2TfmZZ8M/u39zJ0ImBtHsazvpKZAUs67NQrH+8QR801hus+nvKwrdq5RGwKDmKbVLBO3YjT37XGLd1za6TCAUhzudWIg2xUXWFUzPv6murqygG/WHSJrf4qqwFbjrWKfnVbnc9qBnYso6quEvYJHR3IdhCa9t7u5I+Xke9f/W+fjQ4uMSlA1RDTIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bo+Obeocgp4uj8k0K7ht5yvYQm3ejuW0kIlfLsFe50=;
 b=bMdo6wL9CGpsfcah0EehXkKKsht9BW7jYrxGY+A8se1bY86y6yqeyKsVNSvjRh8dkvgAyNrsUJX5y2hAiG4NEwg776RCyO+vqZnr7BQHkzro8nECzAkmhb7DYAiZpD+3RqQx7UI0FgHUSrDdpNVXKdcgDWFc/Hp+FB6GjrkyyhuMNq3/946HvKCkaOXVtGzrAT0K3CvqlUEZvuc7Xur7OS/1Yctlubmbmrs7XicnpvoMokvWixnI8ZU37PmSe2aIEuf8BRNpues+aiKGNtsOX0IeeI7bfUxbnfROYwoJJfmr2DG00V2u+h96yC7vRKVUbcNVnKB0nwZzcIL1jjAdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bo+Obeocgp4uj8k0K7ht5yvYQm3ejuW0kIlfLsFe50=;
 b=L9H641+W+n+VDMmmr0yC2M1zOT3sfGOatFNMqEgG1fWLrW6qfEBPJOt9J/c5GaWWz+59OS1BLZh2dBNKOZDIIgXTbCGKTFbWAaXFssWAOH3L2UN2BNObGTkbceKAzttLJsUCUG6zXWIuxCUs7XmKakneGgAMxm4LIRsyGy9bxjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN7PR13MB6131.namprd13.prod.outlook.com (2603:10b6:806:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 07:33:21 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:33:21 +0000
Date:   Tue, 25 Jul 2023 09:33:14 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net] s390/lcs: Remove FDDI option
Message-ID: <ZL96ut0OJdY8F3s+@corigine.com>
References: <20230724131546.3597001-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724131546.3597001-1-wintera@linux.ibm.com>
X-ClientProxiedBy: AS4P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN7PR13MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a6bd60-c6c2-42eb-848a-08db8ce16c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //GRzlTEzExas6YKMosB48glHBzdBl6I9hOrIY8aKPqLTvVBYZhzNwazZ+hGJSSQIjDSM48pnJvLN7IJA08x7w2+67ikN3EhqIrbcLXqsrUXTDvrXu0ppFgz2d5kQkdTNo1Hp8/F2ijcsS89+baIxV52pSBUvGQNHpcmoaNnbwBQn4Arh4siayLqyXnu1PeuWkQW7o7I3uwgK0ODeH8qKIUX4FtQvcVtgNYYco6hnMUmNMvGa1f5UXeVsFtOYFMMDmja4fQdwMqELaAtccFewhTl4JaS2PDdhPFZOmuPjzqqiNJjZuAUkcKpqcu8DXqnZ0oPbO66jfJzeIHsmxfoSvHaIbvaSmKnxESixUcZ22Ba+1nARMCcB5yqOtBU2d405capCOtSAuhz5OWzOvLUP9gOMOcrL2g5h2VVQjrAahk6xGTT5hFYeXLB+ggQWsqXgZWq4mQDEsYfkOv4HSUBiL7CAgO6GoUiTfrYjX5rcgt7tuqC/88hJ4/ofGb7E6xKgksUPQkEx5fpM6sR1T84dFxBwE4v0d8m14bDBvFOCQ4AA4t3SZW5J5ulT1EKNB4bs4S3S2sTbi85kJAqYhxf5FNfB8r4y/c8CEJzusjvPY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39840400004)(376002)(451199021)(66556008)(66476007)(54906003)(66946007)(6506007)(6666004)(4326008)(6486002)(966005)(6916009)(6512007)(316002)(478600001)(86362001)(44832011)(5660300002)(38100700002)(7416002)(8676002)(8936002)(36756003)(2616005)(186003)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGJvA2l6RnHqH4G/cKWcN6dmGKvdBYhcSKBU1cbMRcLItfwDfgLogZEoajm4?=
 =?us-ascii?Q?jNigdFRUS8BIKxeTB9yOeGwi3djJJijkD5UUXWZV52bn5z2jlv+maZt6k5AX?=
 =?us-ascii?Q?h50aztQ9wCmTnhZK6PCQU4gFQ2DFFLUNtVjWtLbjGtxtqyYeT9Mb05lbgmjm?=
 =?us-ascii?Q?AHWJVEl7r20WzPgM81cRQb2EJ66+0LJXqx2j78Kxy4gGzqQLVKysDAyak8G8?=
 =?us-ascii?Q?/kwQKHy0VJ1ZymTpCjvPwm43Buss+oyDgD4u2SPYRB8qCiiGKn7IJ0GqzuF+?=
 =?us-ascii?Q?81fGL0rSmYy7IOdpHU608/kL/IMnE17Bqnqu7MQLaxGyMDx2Wld5ObihaU1L?=
 =?us-ascii?Q?69+6PYSV8momjId7fXhhaPCiecGmnl+73JjJwFxEzInF0DIUs7GGsg1MmPUC?=
 =?us-ascii?Q?8p4HvFk9A0DZkBCUX+/0yeZU3LMRh5RHCBc6ZxDzgUWUxDU5KPT3B9LqjOKW?=
 =?us-ascii?Q?V3n9mdcuf36SlydAuXvlM34FNq9/8S3GtbsGzcOHhO39BW8vG40o4OGIQIdS?=
 =?us-ascii?Q?z10yQNkvexX+LoT4Vh8xm6Rx+pqnZppCLYa1NyEofeC5MU/DIF8tV2oJpi0m?=
 =?us-ascii?Q?pQLerokLtNpFmlKb3p2PVAqesQfQybm0acB5Z0P4j6XPrv2+DkyEZKyakFgR?=
 =?us-ascii?Q?4KTve6Ym4VQDUUIar6R7eKASEVUPRy1D0eSH7/vmPIn1mMvyShsVn5jLppC/?=
 =?us-ascii?Q?/yR99meZ0HX5Oo5/JiPumZ3ChQMB5WLiEaYzbafjYpu2aGeeik6UdNdGpZMY?=
 =?us-ascii?Q?rQ7gPxG6Nl/GLGF3E4IQKMos+cE3xL+qq7KnjTrVuE4eMCAFm31Mwk7a8D5v?=
 =?us-ascii?Q?CNsXtno4F4LWQUXdm+32j3l5dj3/ZdemvykGA1WkvwXjDqCZEUd70kwBVTbh?=
 =?us-ascii?Q?oDHJSL9jhD19YzMt7J0tIuPix+fiwmg+u1VNWr2qeHYxkMLrtL6pWCxT5QQ5?=
 =?us-ascii?Q?nvi57EAcKRW3Ag+Z5hsB2CHiymSkCcECHKzL48SOGgKcRp4p4OzKq+oPACL0?=
 =?us-ascii?Q?Nd/Iok213eFYvF/yHdAx6I+yTmcwdTfjU5c0fjxA7URc5w32gTYY85/SDbst?=
 =?us-ascii?Q?A1A2TrgvJjTu9L8h6bLl+6sYe9Q8G0Af6gOxSO0Omlv3zLpxa3Pah2k6zfV6?=
 =?us-ascii?Q?Ncnuc5ysvM7GQKaYpMWnQcWg4PFGKdSaJ6jTOOXxpHtgwiNm1h4vIH7xk94V?=
 =?us-ascii?Q?+K/9y7wFrYkVpC9/cB6JJfRewHOVXtp/rx/c+mjvUax3xZxvwbmvbOlEGoyT?=
 =?us-ascii?Q?qsZK3oe5c1KN5uht7xqajuBLjJXmFMwRo+1xsKMpDIS1N7J1a4Ms1y8HGDhQ?=
 =?us-ascii?Q?7FgWs8EOWwNltDMiHG5eEjdkwDGd//fTMHX+XGWmEer50WRzAaLsvHYGs5+N?=
 =?us-ascii?Q?aDaDOQqgaOB10tLhAnmLF0Vdgm1+NZaLzD92cNSNbBP/xi4485kG1aogEoNw?=
 =?us-ascii?Q?B5LwcNCIsG3m8yXV+t/IY0qvGBt+4q7IBhu1RibnnIGkGiZmcd2hq3HE7kh6?=
 =?us-ascii?Q?C+HfC3nOK51/atGIfwhY8JB8fyR9FDOTsTEoAV36WSWtPQo+N5Itn2MVulgb?=
 =?us-ascii?Q?6qSV3UeWy4A0TuYnMXST+8kyJSpQNn/4dZubXTOF+v4XBN8NpBuxjWj2giLQ?=
 =?us-ascii?Q?1pE2otxlkaJL4PJIpyetj2u1thaWLFE8V9M64z320BQVwPMH5XfuMbGLNXrD?=
 =?us-ascii?Q?t3SyuQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a6bd60-c6c2-42eb-848a-08db8ce16c27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:33:21.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZjt1qgNRPCr5AOgGjaMI9e5VnVEla11X/pRiqnGAbMfIcwNN6NsrFN42elBir4omqbHspnHIc4CVPfVUfgrAeEDCKb+MhDmfJz0MH77Y2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6131
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 24, 2023 at 03:15:46PM +0200, Alexandra Winter wrote:
> The last s390 machine that supported FDDI was z900 ('7th generation',
> released in 2000). The oldest machine generation currently supported by
> the Linux kernel is MARCH_Z10 (released 2008). If there is still a usecase
> for connecting a Linux on s390 instance to a LAN Channel Station (LCS), it
> can only do so via Ethernet.
> 
> Randy Dunlap[1] found that LCS over FDDI has never worked, when FDDI
> was compiled as module. Instead of fixing that, remove the FDDI option
> from the lcs driver.
> 
> While at it, make the CONFIG_LCS description a bit more helpful.
> 
> References:
> [1] https://lore.kernel.org/netdev/20230621213742.8245-1-rdunlap@infradead.org/
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Probably this is for 'net-next' rather than 'net'.
But in any case this looks good to me.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
