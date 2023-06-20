Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BCBEB64D7
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjFTTRR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFTTRQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 15:17:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2090.outbound.protection.outlook.com [40.107.94.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCE1B6;
        Tue, 20 Jun 2023 12:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAbVCOVTS5m9j4eXlOESFWK6dXmlmM8IhV3xrJFWNONJm2k44/U9qEGDdcyHdUePp6k4dKSDgeGDkH4N/sDo/n+/j1ILwWpOU+MTUTBWldsJcZbWBZHyfaJ5CU78nV7uhOskoO9qEJ/v8BCgVftSHzeFanW9oKS7nCX9Cvic6Jn7RdRYIDjag8BObTeVd6ottcS1TKCfa/QgIO7nOTyCV3zFFgomhjYlJOPR6iTmDsINZs2mTkXDq7IZmnU31ZjSyylyBC2nqwvNAq25CnWXAx0DZm85bXrYudnqO9O30vl/B5btcIZ1hCWz8SfnANkqOqbNn/5HYyCd1hIQyXG+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSq8FMloUIJPQQy8tdbqDYaycLj32k8nW4ilRYFwWgw=;
 b=Z+ZlX0YcaO/XQBzB/KNNsAzws/SqY1QsfUw9PPv1eC+oJMjzhBjFlHJiN2z7jhzc9uhjIGuzE4j5T8/slxYVWfSsaN0MSUDZkXLzGx5QV8D7oMOfhAmfL5yQiX+VGZRrf0q7A71ncUZur8wVwZWrNKVDmrabdIxtG2sGYabN+60N4nkXGmfpzaz7tcLMOAgJo8FZvQ7Km4IAYXhQbW9X5SyeLRpo+nCt5DLzbLcK0q/Sn7DmigaIA6jFplc8J8cJ3nTj3qN/foLyQ2NfbMltmNlNIHucivdJCEec0j0mogNXLvEfaA3Z9VRoiRIsR371ufFHSHC5PfpU8T6j66YfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSq8FMloUIJPQQy8tdbqDYaycLj32k8nW4ilRYFwWgw=;
 b=v1d8xGp8HsTYlBuHyUf8U1k52ixMn3Cz6RJ/Auw+PUYshp0ps1457QgP1jPS54Lw2HmNVGJO2iY+8oJSsp83IsZzZHqH4pIZLhE7PjH7Q+gJyR6lHjIcAOwnfBtIchxlhOP8kydUH5ePUyfY0skgbcgjVcoKMCPRMCKyu+ZhZhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB4054.namprd13.prod.outlook.com (2603:10b6:208:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 19:17:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:17:11 +0000
Date:   Tue, 20 Jun 2023 21:17:05 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Subject: Re: [PATCH net-next 3/4] s390/ctcm: Convert sysfs sprintf to
 sysfs_emit
Message-ID: <ZJH7MVw1uydIUQQd@corigine.com>
References: <20230620083411.508797-1-wintera@linux.ibm.com>
 <20230620083411.508797-4-wintera@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620083411.508797-4-wintera@linux.ibm.com>
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fa36ce-094a-4369-43ec-08db71c2f2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfEJh5c83Yp0vuSyOqs/d7NkKAf89I/vtaerQ4mfc0FCGJgEEfqB4ACGYJeP5i44t5x4F796yYvfmYfqc+Vsr3xdrYwJP/4nDaoMYLpT+I7E5i6RlYSb0BXCsiiZ4i0QbdD6mBgwTWWkkw4aijtrB26OgfYy0wRgjRQvwAXpOvnOG2+CJSFDomf8//7OIwC4bXSlVBIVx9TZDEXYnPY3WGG9Ef/OEXAy+kJhW2BVW16vlq4PCcS9YQ6iPcMf26VwDPWmDVnWgbskAl2BBC3TgqNBR5XN1asxZVpPlKCwz+m85IvW285HHrEe+9eIFHOYZTjGv3QtAeL4plA7424GDDzL4JsnoEbAXYgw34LFyiKhU0CU9HYujjWb2hT+V9bJEMsTShSSMh9zSIMqXOBmW3JSooOPSEI0x9XHbMTkF8CiWlOfuS7sGr/eEfe1oxqTZs04hohFOdl1ZH2+ipIIO5plmR67T2Bih4NLWWC8qfqcrMnhK0HR/hNNvwnS21HwcioF+yCahLUvlLBUQz4gg5upe1fLiQB2+PKeDt9EMqv2tYGhIR4gwHHOvQzkH1wL7mlsRyOJQlxFdBiEJ/kMjauVIsesxSeqwJxWXbnyl8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39840400004)(376002)(396003)(451199021)(66946007)(36756003)(8936002)(8676002)(66556008)(66476007)(186003)(6506007)(6512007)(41300700001)(38100700002)(5660300002)(6916009)(4326008)(44832011)(316002)(54906003)(2616005)(6666004)(6486002)(478600001)(2906002)(4744005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3WkSBNrQgpnsaOu9845Sy7oKc3y3IHoH77d4c1g/gk6Z2pBaX87wFHuhAIF?=
 =?us-ascii?Q?Rr3ivjo/9PwP/OtDXRHtNbpmpvgaFgA5d4G3z+5Bw5ME2FkG/ucYyNj7XXpO?=
 =?us-ascii?Q?vhtEUi35jVQ4AyMLTZRl47lSgVmFsDKuuSe9octZRwophYRW6vNdifdsgKri?=
 =?us-ascii?Q?LDJOaEacRSkOOtA3genlSra4zyv1QRmzckaute+oji8o8CPQIGUXqraRzsax?=
 =?us-ascii?Q?Bz86FNKTe1ax0h7JCvLl0OhGys6u0ucVHmSkbKw7ducR3XowKtVCrVOkjVsq?=
 =?us-ascii?Q?96XW5HAIflelo1C5hT4sEIo4TDlCfJYU3nfXTAsNwjog6yNHoTiUeNOlZ7eR?=
 =?us-ascii?Q?9LNzMBRe9HxlTAYl5FxJmT1nLNNaIqxXM/rwMuF7GP1LlIrKUIcYqNL3alup?=
 =?us-ascii?Q?nNEHTGv1FQxg7caRnkFIYmhT+GumExZHFPz13Pv3OnPWZaHJounl218mXqi4?=
 =?us-ascii?Q?6zclRVEvFzhMZD7ntJTpsj/ryjggmZ2S0TcdM2tUip0GDCzfgKK+IsOG9+OW?=
 =?us-ascii?Q?HPVVl0i4WFzoKE7STokqSqwB6H/w23kjnbHTFLx/gZ6VHXlFJ1gPBXIboDuE?=
 =?us-ascii?Q?NcIMWOBu1+VGznnbeNzpj419ENWiWBL1kq3+yin/IwlYXA4asOPwWrqL4r8J?=
 =?us-ascii?Q?6NfbRXKMniJ2FcLdCJoaqGb8yvCXmB/SR+Pyp5kKk3ye3Z9h0MQqDoOcZno2?=
 =?us-ascii?Q?MNOrnWM5WJzYyTvnDxagm/c/gup/gZ76qPZy7LDYag2Mmqaea3cDYewd5s8s?=
 =?us-ascii?Q?DyAbD+g+6Gg3XJ54GpDbwdWYu9kk2F7wO6G30+CQydSm5GSNAOupECLhXRXS?=
 =?us-ascii?Q?F7mroWCxjJtGcZ4UQeakMnV53oLB5aoP8OKnRQZhzIIQGJGSKJiVZCM8fGmb?=
 =?us-ascii?Q?iClUZi4Cyg7dn+DtxD3mf5l4KUXgrmHITjf3d5520rZrIC4zHATnHf3FL6Gq?=
 =?us-ascii?Q?oNfiGghvke30+BiffussgiQDwoDcQZC/3HbddjlOUBYFrhA3aTSyO5jq8o+E?=
 =?us-ascii?Q?MZE/D6DsLN2QGFn4HV8jmMjms3LUnUqDw5ADBYRQp8MPNVkNZiuZhlsDjkjx?=
 =?us-ascii?Q?p8oqxA7b2nW/n4kXQOyzgt2SwrBNhTmLLtWjvBN/fLC+3FyDkJo/3NCQ/FcI?=
 =?us-ascii?Q?y3CepKzm9TeAOarcDlU+uLCFxRSNyYjV8mAQ6pecsJi4fkJyiyHWtjTLmdO4?=
 =?us-ascii?Q?4qpzQuxRB9y4L+KGtIMKl0Dq06UUSx0HNV99fMyj376KAEnXkg4YhXbB+rpr?=
 =?us-ascii?Q?IBdp91Z1yIpNAC/VkqjGih2ABIevgMR2BfFqX/nv4qnB1K58PNXmH1MUMmF/?=
 =?us-ascii?Q?o8aiWd1bkiN2v4krpba/ozQM4elK0sqKus0sD7H/yTXx0N8aFhSRYj4wQDxX?=
 =?us-ascii?Q?u+roJ08GOQLzW+8rcZxkIgNXxdKcpLPqD6l0dmVxlOjSLvYF8nsaHozJA2+x?=
 =?us-ascii?Q?z9GILzi9qKmuVJwdJegC5zVlRfJdWtEe+q2KYdXrTmxIyFwtYA4HbVXD2uFB?=
 =?us-ascii?Q?Q6cdAQZeGwGa9+/6PM5kYTYAItamD9N2Zpm2fRwsbtWBSj3asENpiby06uw7?=
 =?us-ascii?Q?IRrGM8oIs4axIN/mHEEUFEiyiFLSgs7BdGhSSaEAHHT6GNegLfhHJvcEtmTK?=
 =?us-ascii?Q?ySxtBwXBlLJksg775pT5qSzvAErfzlEIrbhWTBSPKDq3sbvo1wyTytTKZDij?=
 =?us-ascii?Q?vOzWJQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fa36ce-094a-4369-43ec-08db71c2f2da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:17:11.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CB1zu9GensLDGFNDfVAAbHj3vd7oCldrT+fA8FCQXh6qS1QN7blPWanvqcAmsUtp3B4oOs9SxZDzSxjE04M6fKKUY9WyHZUFFki7FJ173k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4054
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 20, 2023 at 10:34:10AM +0200, Alexandra Winter wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
> 
> Following the advice of the Documentation/filesystems/sysfs.rst.
> All sysfs related show()-functions should only use sysfs_emit() or
> sysfs_emit_at() when formatting the value to be returned to user space.
> 
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

