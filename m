Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA9EB64D9
	for <linux-s390@archiver.kernel.org>; Tue,  4 Jul 2023 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjGDUnU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Jul 2023 16:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGDUnT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jul 2023 16:43:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761AE10C8;
        Tue,  4 Jul 2023 13:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZb/GESilUxFznK3815tX0RHw777kZrp8Xi3lyuqAPU+kVHtVJ5aYdLQmO/Nx1H0dInIvSZZTwcYDrEP+LdHOEOo5Hw5/uMAL8o8ke4ilBV1jhn/qK+X9s3OiWsEfPWmyTTeGqmXi7QX3HWhWhHNVIe2b7la8gu0ipyvcabh3tQXSz3vLoImG7b7I3xEIMVei28xPkD5S1bkddLavjozo8sTIWl+Iw/twwCm7aAtGggZMdeMYwZeVonb/YCS3ucQ37B6djMmNZpwUNTDLIJFrECGfwWGT42pfQ8IV8MvuijvIeHYWAnUgjXzCpREDoTXaAi3AGG7LndCzNuiErZafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sVcUZCoogDlUOhI4yvnSU6DYn9WYBa4uiFyYHsgrdI=;
 b=Kdg8s8V+/Gs1UOmXj6hQkESrOtxTuHautRPGaggafRcPo9DDGdCroidL5oys9dMjwZfkxZtRHGjqZ6gdy9qu4FgomfYaFgXDs+IhgmrdmbP9fzsq+HUQFPp9SY8s51ZsCyUcDwmb08OoWLrneYu7pu5VxHufc1owez1t1/xYyz3PpPCS25ZlwxCgITzLahfilgEOhoXRYXjbIy75WFeFWlPfEdGnV5imY8W8/ELk7sRloNorWn10sQKJR6PUADYb5ALG0UwsDaTaXbHS6baBCVcfFRiTi+4RqxLSiiAibapFxuM0y+g4+cygcKPHEeLHqmxDv0TuKr5VLtDJ/79CcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sVcUZCoogDlUOhI4yvnSU6DYn9WYBa4uiFyYHsgrdI=;
 b=agNGnCJsnZqLHzSLg/lXmvgC0L5lTbx0hJihqB0cwcY/95jyCISoO+ztKjrUPcbGggTin2OzkSkQweEaWFfMM5VgVHltfU/oQ3USn75LLYRaLez+p/9zm7g1zI0DLl3x626ketomAmhGZBfgiFKpuv+S1AFXypNUva+VIAQcNuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3630.namprd13.prod.outlook.com (2603:10b6:208:1e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 20:43:12 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 20:43:11 +0000
Date:   Tue, 4 Jul 2023 21:43:04 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net] s390/qeth: Fix vipa deletion
Message-ID: <ZKSEWCGDlJszBFW6@corigine.com>
References: <20230704144121.3737032-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704144121.3737032-1-wintera@linux.ibm.com>
X-ClientProxiedBy: LO4P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c7c94b-8d98-4291-784e-08db7ccf4828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+TLZfWBpJ5UcVYlMvwo+6LbBq6wfGxeDqmtrcEB5dJWepCAm5dH1UAgVkBs9uMsYyQAdpCg8X8mw8pmWjv8fI9YHqwYU0b0UPMDBTbhJixpznKyNpX/29KX6sHEpHwBG3iSYe1reng4ATvXq9o33OHINZ/i82Axo+WyEbBs1yx5ZIM8LNSd/gWB8OpmNNOLKzfYgWNfONQ2E48lYgmf/XFZeHpdn3HnzjTuKUKAdzuH0ycxfT3cA6I/ATJFHlv9s12FyLjaCcApkEQ6K9ovCd1PywHaTRegcKiZYLKq1HwnUpHwS8KwT0gmFKcy/tzQLxHW93ZtELzGqceamlK2kDHn8G0xf8t29WFifk/+xcraACjnOgigc9YN5yhkLVdKpVFIzoKM1ijNxzH6enkikD7F+WpItm/AJ96W0BN7BfJvGkKodER6kY5A29NlOx6hnE3rHoQbhuq9IJz3XhV+m4SsdgJPAr0r1IG0wR4GKFizrwEPzJsao7AzMo5eKfJ326kp5qwpDEqNoGEFozyHmsz7f7CH2DLDMPw/Pfw48fLiGrnIpvMdvC5hoU+0cdTKMYhCfGh31x8ih76hik4txYKbMKnpnlP7SQ1jvvYCScs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39840400004)(376002)(396003)(136003)(451199021)(41300700001)(6486002)(4744005)(38100700002)(6666004)(2616005)(26005)(186003)(6506007)(6512007)(86362001)(54906003)(2906002)(478600001)(36756003)(316002)(66946007)(66476007)(6916009)(66556008)(4326008)(8936002)(8676002)(7416002)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?994j+lfgT3R4ps3N3f4kFpTB2iKlwqabkg0rEhYshA3qegmr3FPpym5JNscR?=
 =?us-ascii?Q?MDOBlCLd5Z+baZBBXlGMkY1W7lXwlXRn6q5wWhXJDY33actgJjIzGnotTAZw?=
 =?us-ascii?Q?HiwH8x/89Zva4RZoY+IXe3BzBMOJTIbUvFo5J5ZOLB460Poi722QllZqz0dz?=
 =?us-ascii?Q?esPaP/y5RXIkr4efOmbq24f2trE6DO1RZFLaNAouVL5NHGuH2EfWjTNI+gXJ?=
 =?us-ascii?Q?jcaCiYOGrZFOXb4nokh60g7M9abCc9UZ9qwUjCcBaNqnCDiXMNSEYvWK9uIB?=
 =?us-ascii?Q?PywODZHNwNsdtouru17McSzJXzm0BWwJPa9i2M1GmExc0YVbSpuf5SDd6F80?=
 =?us-ascii?Q?wCnbfzXsD6i5aDz94Z/UbhWoQInlvA+uLhrVBQl3AZd3pnuoWQ2HRRaryX7y?=
 =?us-ascii?Q?o5i3NLc7nzmuawRyfsstpO6/VjL8BQNjWVtQAPYr06JC43rpEBaF6rfT0Rfc?=
 =?us-ascii?Q?y0IBPKlGDbLfXFyWf10viOrDtgbyHomRqtwD9YnA0DpgmkU4LJI6NlHuJjvF?=
 =?us-ascii?Q?0i1V6wRcwTAH3sNQ1N5Ur/ifWF4oTzK13ARqjQhJbNeIH8Mmlua+TpQrO5fD?=
 =?us-ascii?Q?iqaSo/7WAgLme3aTlExpmqooV3SO0pm+bd0YlDL+RZIk+Q+14gHozthpy06S?=
 =?us-ascii?Q?GBDSJMFh9G3OKjai+4/TEkjSfGhnSvuHs8e2kGhzofVOdksGJBGlPo2Sbfrs?=
 =?us-ascii?Q?938T7IqoA141IFEgOBUPYmxUgGKAq0aVgyNYfjyXWq0ctWiwC8fV4B7NTc1f?=
 =?us-ascii?Q?tgn53HR1nEfGQb73obvtQNtoYiVi9J6rw4wbaHK7NjHoqF8s1DpdKBvTrtGb?=
 =?us-ascii?Q?ps62pxkTgXSK5CFrkfX8R2uknLz87E89e/L7JAtAOm5Fx/NuB6igN7516KKs?=
 =?us-ascii?Q?NVQxkGSRqvAvfwxwerlmi7GPHbIUjW4D7Hci9fEhLw7ZXw+2NteV1dTNQk/b?=
 =?us-ascii?Q?yjqU+2WlFuQ2STJ2fP6je16WsLPkEk8qXc06o7JxiiabOE4dNz6RoQQ5Ypub?=
 =?us-ascii?Q?HMeotlCjNlUKwzWHfOvPIKWwyVg7Z6uSIUuZC2whq5UV9n4KIZdd7oxngpuS?=
 =?us-ascii?Q?9zfpWtILtVo/iwjEAxjFATJDaxL9kbeyP0Y4cOIQ2xf7QjWjJkwkV2+C6PXU?=
 =?us-ascii?Q?Jk36ydWCl7Xd8GVoalUVoWMG7l/1cW5Vvc5Nyqk/C1ByI6dTPW8OlUxL+10R?=
 =?us-ascii?Q?jnY7jr+K6WyPiJcO9L87M2Txbv4D5Nndy49RsyXn88ZYvrnGV9kNC9FAZyA1?=
 =?us-ascii?Q?Auv3OaWDVSK3lh6kwlZZb2zOhIPjZ04vLc+WdGrHoA+PH12ktP/rDfGV2lds?=
 =?us-ascii?Q?Cl1biwWNxjIi65u4JO9D5/kzLHtvMJblOPDvlYBSdi4rrAvuP0MpJERoBkZG?=
 =?us-ascii?Q?lh9/BmNi7HemguCldRfCAjLq48TGVMgcGXDX+QGgInwYn3H7nt/1uwCY2Y2k?=
 =?us-ascii?Q?Fz2jFiqnuK7iw3AeTsVBD87ac1owQwdra8RX7crVNGrWRi2niWiGuqu/StLQ?=
 =?us-ascii?Q?8MlWjg80wLattE8ky4Lzsnzm6QflJ9qsKNVARMkX1zvxqWP4KxHBySsKJQLF?=
 =?us-ascii?Q?zzDaFKS+5EIwIeK/vSCZcWiO8Q88CwD2xO5BalWCj1jZCXmbd5aVjFVXiLop?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c7c94b-8d98-4291-784e-08db7ccf4828
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 20:43:11.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhgLEtPxdL9eLi6zMN7WiaIGtgtcgiQqhka/EzFdIQt3NaITZxveo9LDM10/GSsHxc9l5Z7cyB74KtlUXMcb3hiu1+OAeX7ZrhnEyMRk6ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3630
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 04, 2023 at 04:41:21PM +0200, Alexandra Winter wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
> 
> Change boolean parameter of function "qeth_l3_vipa_store" inside the
> "qeth_l3_dev_vipa_del4_store" function from "true" to "false" because
> "true" is used for adding a virtual ip address and "false" for deleting.
> 
> Fixes: 2390166a6b45 ("s390/qeth: clean up L3 sysfs code")
> 

nit: no blank line here.

> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

