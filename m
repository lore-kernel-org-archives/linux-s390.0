Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01CC47080
	for <linux-s390@archiver.kernel.org>; Sun, 23 May 2021 22:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6C661003
	for <linux-s390@archiver.kernel.org>; Sun, 23 May 2021 22:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhEWW7R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 23 May 2021 18:59:17 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:48289
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231980AbhEWW7Q (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 23 May 2021 18:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj+XqEfpB8Ph/CZ1MYox6pm1l5BupoIVfM6KZysLlZzeSX6AbWjOdXf3mfGmUah+KZte7Oe4cxgXpcpvkBfWFK9QgVUaaVOQ7ymgKEhsD3n/7ROrBYB+42NWeepcXWNo3B1R4LsBNBsxEgBefmOFj/qOjxtu4sjeszi7Gwgl7Atc/HO2tZCtK6QpjoSUK0UE+WZbuCEkLWgTRDpsDZSEicvqaN5FqCA3TJGbJOtiAHy3nIKD51g3R10ecNe6JJVIWhMFzsdsEWRrKqHGQ5OF45HvrWgn6pYL951MV7XENaqbKM8y/qYd/3mAuLp45GwLoVsijp1L7qbnPtV1t7Cv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvbFARpe/oVnQDDWiJWX59t+yNcvVXxvISmRzPXsdJg=;
 b=f0wi1TO34wT7xkveoaDjU0L44VtXXmGavKbKIMLI16EgYw+r1ONv0z3hfbQI+x/RkAnDqeGD5BXb/sLKSP/UoORXgu2ckXlyPi9Kqx17i5PTyfwGZGq2SQt+0z23ylu38Wfj08tzyjAYyOFtoZ7zoAjW7JZo2c5EooB7LqQ6apqAKGNsGyB7Gms5d1VAuGu56JTBPsXQ3P+GQvkGpp9cVumveSQnaNnqsyOUOeqgDBIkLSWNGdyO2URiUw3/OKbt3ldxCMeoKawdPTT7bLLKTY0BYQAyo0l/pqd53xwu42dYatzErt/Uokery7bKR2E3edyeX6+updA4YxX2Fi/NYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvbFARpe/oVnQDDWiJWX59t+yNcvVXxvISmRzPXsdJg=;
 b=I3rs3/HT3CDkoPMT8XSVuFljov2/tHNnAFT3ZH3D0u7Dp+ndzksu5DU86j1mvPBGrL3AaoD6SMDQsi0MoPhRIlmdnPS4D1NLCuTJluqGqlv97E0fRFivjgB4Rv0UzNb5rYlmAxvucUHWe/VcWCvoC4NMAqzMJZclDImy5nF+dyACeA4qqWCNfgx4txpcfEELvSssvcmY+3bA48V6XdadZNXtIJnLRQbCnv5Xe+Rk/tWQMCreJ3vUg4nYfpvi5UTq6FQKsStUQd503J894r8BUbrPms0n3bknd6WrcFhjEULQ+Sv+Ivicb5ql7rFQF353uf53gpkDam/4en2Hxr5Ycw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Sun, 23 May
 2021 22:57:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4150.027; Sun, 23 May 2021
 22:57:48 +0000
Date:   Sun, 23 May 2021 19:57:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210523225746.GF1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521193648.940864-3-akrowiak@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Sun, 23 May 2021 22:57:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lkx2Y-00DU88-Pi; Sun, 23 May 2021 19:57:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f38c5ca6-0003-4bf6-6edf-08d91e3e2f6a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50794178E1DCCF9EABCD55D2C2279@BL1PR12MB5079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HL0E1E7CQ4udseMLEbiQeTf+bu4ocawY7UHzlRutvBtuEXVg/uKODNuvOD2wuuFJrswhtRWXjO8ANHMiss38XkNylnHXg622CdB75EpiAPasHkNLHGMoGHXXR3luxGPx3e4ByFsqDUVKH653YB0A6Yy0UgnS8l8TJqMlM/m8D6pA5nlQkwyEsRhqyf6zZI7nJODO4MYln9WRKlEBtsLevQ2fhCpic70mtYl8Wsxw8vjAYMSPFkqRAad9KZHizj7XvknpjMW0NHwipBor/kxGJkUxrBiL/5IiaRkoPn6kK+NcWIjw05XmGtMwgWVVjhhBbjyr2GhLC7C4y0tYyZsnMWymFxT5DMZ/SQjRhKoRXaKR0VeGl7F3NxI0ITYbeWKE4u/aRgFF1w/+N/RiPa8hdXSFSZrrhin3sOKL2EqG+BvgN8K6eboY3wVGu8VwCcgP9nsB4b8kulnbY7Mhph6B5f8n56GZUDwqaonLl+v40YH8X7QIiY1gOzqElk/b5FbADdIzjeMFa0DEhpjHgqxBbTGfN5qhMsKCmgIlcUX48ET7sxzL4ruGyQlc1GlzDfH+3CzxK26pDH5AOg0tw21oce49Xf1e840dVXT75hgQYgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(4326008)(26005)(38100700002)(1076003)(186003)(4744005)(426003)(8936002)(36756003)(316002)(66476007)(9746002)(478600001)(9786002)(66556008)(83380400001)(2616005)(7416002)(5660300002)(8676002)(33656002)(86362001)(66946007)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LaJHq1xDIL/QF96NYmKGz+9u3+B2+7tfzqYBal2dh6wxEC803W3L8850Zti5?=
 =?us-ascii?Q?VqC5ZImHFGXifsG+FPzsE5FMeM29eE7jdHQ/2qMIasYUhCE/HT34nCf+sIcX?=
 =?us-ascii?Q?NqPdROGII2dEalCguUbFfMp3t4AG6gC0nfrc2+sieGhIA8OncCDiagqQp8bp?=
 =?us-ascii?Q?nHoVCNTcYqt+JEI4yKvFKjiyUyXkUqV5kF+STKdkGBX2nfW5PdbsGnSSw8mL?=
 =?us-ascii?Q?+3ByUg574tlxbfH2XGKg0tud8ai4IAa6B3wCA3hUYqsWW+o9BdPxT9ZdctkI?=
 =?us-ascii?Q?8RtPFTCW2Pfir/6k0spr+1Fvq/iZT+h091e+3bBjmagkEVnMKGMPDOa+OO+Y?=
 =?us-ascii?Q?hUBnzUo6bopFztDNzOltXCiaa41ROHazarcRn/UyYgEgpSau7V3g7xMphVNT?=
 =?us-ascii?Q?+k/+AEjWn3rMVDqp/RUSRL6h80Mk1Ph+//xgyzQX6pa1eNp4mANKf1eKkNW1?=
 =?us-ascii?Q?QEUuNRMhbX/6JLihvdZe946do+b06R4DAyGpKCaU8dpyA7LGdNfEo4lg82cL?=
 =?us-ascii?Q?DBmXApSywczYd2NA/7dD2rSQDdxCpW7GI0IR6NOdcIHq8ZGEBa3EGR/gIJ1G?=
 =?us-ascii?Q?MsdnxLOEW3sSMxt6jk7EihCH/DMUifm2Lze7YmT3Wl8/Dmnuq78YeB9pBCNq?=
 =?us-ascii?Q?lntTomK054c0otwYTfMeaztZ7zQrNzGfxvIn+OVgCda8f2fcAvI2qILto0rA?=
 =?us-ascii?Q?26GtNRfyKvRqkNL4FYoO+AJT4UHYJnJW8y9mBl6UG6PgYJ5CNhgEmG4JK1De?=
 =?us-ascii?Q?Ak+bKSjCitSHQ2MJNamzSvavLmgo0ucwgHW/NeJzQS5320tSOUCTFHKAXO4M?=
 =?us-ascii?Q?R2F+K5VPcYkpzxdw83Z/0qLj8nKO3hJ5XPO561WUc8yb3l08R7AGqJJuGhrG?=
 =?us-ascii?Q?ArUasrkP0mLerntNcI3SWQcpLDlEYn5XcgoSP1lbgrIb7U68QGXyjVuxkLjG?=
 =?us-ascii?Q?pkJ0M/n/RPlawrftoFQeOysomaXvN9q6kPyqz78sB3besrcvCZi1mWbSqye7?=
 =?us-ascii?Q?Ytycp2xodsBy2LhR65HWbvpcmId67WWvCsZxqFvMLv9qirTkS+aF13EVljdI?=
 =?us-ascii?Q?aIWGY2b/Qr/DHOL3yz1ycA8xDdk5ACS5vFAaI0qWloymW33zjnPgAuE1aK4M?=
 =?us-ascii?Q?22RcTjNVoit0GcDXQ6OEuNkklS8ZJEmLl3PoyIV7h3Rm/8O44mXwBJJ/rDjB?=
 =?us-ascii?Q?Xk6FKhfElq+MjeCtGp7PFUElaIzN43BnVAB8c6vr6YPRkqRa3L/XWDbdx8ht?=
 =?us-ascii?Q?XwzYQ8rq2e+sW6f2ya7LuqwXCIAN1ZTvo8d5p3Toy9KLZ4ArhiTQE8vrqm4U?=
 =?us-ascii?Q?ZWgfhC/PXL+J6Jhs4R3QKLhT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38c5ca6-0003-4bf6-6edf-08d91e3e2f6a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2021 22:57:48.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfc2G/Afk3sgz3XnrX2SHZLrCCCmnfU8eyN9pAPQNx76Q2m9y5wGqfAxiJv2Ucn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 21, 2021 at 03:36:48PM -0400, Tony Krowiak wrote:
> +static struct kvm_s390_crypto_hook
> +*kvm_arch_crypto_find_hook(enum kvm_s390_crypto_hook_type type)
> +{
> +	struct kvm_s390_crypto_hook *crypto_hook;
> +
> +	list_for_each_entry(crypto_hook, &crypto_hooks, node) {
> +		if (crypto_hook->type == type)
> +			return crypto_hook;
> +	}
> +
> +	return NULL;
> +}
> +
> +int kvm_arch_crypto_register_hook(struct kvm_s390_crypto_hook *hook)
> +{
> +	struct kvm_s390_crypto_hook *crypto_hook;
> +
> +	mutex_lock(&crypto_hooks_lock);
> +	crypto_hook = kvm_arch_crypto_find_hook(hook->type);
> +	if (crypto_hook) {
> +		if (crypto_hook->owner != hook->owner)
> +			return -EACCES;
> +		list_replace(&crypto_hook->node, &hook->node);

This is all dead code right? This is only called from a module init
function so it can't be called twice. Just always fail if the hook is
already used and delete the owner stuff.

But this is alot of complicated and unused code to solve a lock
ordering problem..

Jason
