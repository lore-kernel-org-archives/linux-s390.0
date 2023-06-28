Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD75BEB64DA
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jun 2023 20:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjF1ULk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:11:40 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:61793
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232141AbjF1ULN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jun 2023 16:11:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9Ei8lhy+Z2lXMwBOOyKJeKsCrLumoEo9FWgiL9lRmJL6ICDoFeLCrfKGLz2n49G6yn38bWd8/L7BTEaRZRYNnVixNNOpBW7G8itTJtsf1ZHYpV5JrXXvnduewFuPj+44csIJmLG77oZ9N5tXhgNF3VEdDBPtgnyYAVt1Rz4yANZMZUXirM6ST7hZfIGS5sM4QB1SnD/T/lRnwvglGwQvJGwKU3N9hPX6R+zGG+plfW1VsrhA/OyBUE/QJXItjpfTKtR1Tj8WQXhoQDg8Tjquj0Gg3zIedkUwrdsJS6t5tB50aNt7DYkxIsnYp7xcnEpGF7BOb8qhkQNuo1LH+0KRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOnJp6Vi8Y7ip+w8yT39mKwhFNh3PPVOfwoX2/4uD1Y=;
 b=OYKS7iFCcZtO42gw9HI/J7w2ZJI8TpJUVw5V0ZA5WUz6HhPtUyuKODaX23w/ljbkWKC9MYZ9hIy/RMtjPy6XBXAm3L6iRXtEHUrXsvhppRFPN3oXkmOty/1h+n1KQVie0G/mXzfoJXh+SWqx27ByvUL9DP5Ch/n7tSfckZVEa91o10skU9Q88w6TOJXMlnby5TxXDEncWtv3o5P7CFd8BvWVgijWJbd6dWJ9HocvtSDJ7QwSO9C0pLYp2SUCqYF3O3oLo9+RuUeWiJ6scHelFbMHDbBdxkoFFax06P0cw7JzilOd0tx92WE5BKwbAcgJbXkOCubGYHqJ0rUG6HYPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOnJp6Vi8Y7ip+w8yT39mKwhFNh3PPVOfwoX2/4uD1Y=;
 b=mQ0toctk+6OnFyLiYAZiDC6ALXAErkEDQtOj08RrwdhPxiAVxbA3kqp/XRtWNiZHBQsMg0yNQH/7nknFZ9lWr8lVO919/v7N7lRAVOf2WsyDrOm7I/Q+2fVqqaOzwYQdAtJikEsRttEY5aDhaFw96SC0c2fvZH10DPRmNSpL3jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BN0PR13MB4565.namprd13.prod.outlook.com (2603:10b6:408:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 20:11:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 20:11:09 +0000
Date:   Wed, 28 Jun 2023 22:11:01 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390/lcs: Remove FDDI option
Message-ID: <ZJyT1aWFGqHjxofQ@corigine.com>
References: <20230628135736.13339-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628135736.13339-1-wintera@linux.ibm.com>
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BN0PR13MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dace52-6504-4014-5b99-08db7813cfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhjAQUpzuVgxdIadiMT8eumCPZUUc7QSBVr2U1o9p5yqx0Gt2HN39ZSP2Uax24RiWa5/TIby30vtWtYumB48t1CLYtS9ThDOcw3Ldih4s3QcxD9spCks+nRQDjon6f7glttSk0F1wIPKKPK/gjcW8/+1WtWiiuLmbM0tCGcw3+DTwdURnG6Td9GsXgDlhbUarnjbneWN164aCG4hrUdNEy3fcQFN+ZrvooT00R021YdSKfKmgWpGOdCMoGLhAuKGTtWTtQh0/DY8uaI1m9r5iwFB6BU0wrXKRTq+JZSLS5X8Fz+kXft+1FJDM1a17jExBrKLEUQxfy9govyGWYQbbDJ2wCFnpYywWajGjKV0iunmuD1d04HDrbjjhjJUbCgkRD65dWTc+eE7NYNFXvs1evGh5dlLx2GsIdWf+JNnDUQw7+VjGcSXM9rCON9MifYaswcym22CsVQiC9X9Jj3Y/7tKlAv40lMyyCCIeeTWUOlMGUomcNK0zLE/avI6Kzv7JJIsIl4Sx0e2MMDQkcThKNPe+9IhJS6JdW7J+L9+VkwppVuVAlcNcktFZ1kmvrzMfeHIQZVhR6TLzbZMvVob5KjFxOx4CqKeiM8uttCeJ6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39840400004)(396003)(376002)(366004)(451199021)(66556008)(66476007)(6506007)(36756003)(966005)(6666004)(54906003)(478600001)(2616005)(186003)(2906002)(6486002)(83380400001)(5660300002)(44832011)(7416002)(6916009)(66946007)(38100700002)(86362001)(8936002)(316002)(8676002)(41300700001)(4326008)(6512007)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajzsvzQ+RdEejZCZYh1ZXq3dMcdbn98yDl7rHm6VaxU8k/n/iNzEHtLiV1dc?=
 =?us-ascii?Q?MAq29iKPzACqn030NlUkT4CJFe3Ah6nh0q9XWfnND+gjvyeue2LkVywMjuGI?=
 =?us-ascii?Q?bKX+qcCgcFyMxNhP8wUDJvRJ8CWvpdt32drzPLH1WEVd2PA4Md5X7EVfnYTz?=
 =?us-ascii?Q?LRqbdNkmbFXKNYTObnwpElgddu17BnstZhm2H0XH7lGmc2g+L3YGFFbnJ2Is?=
 =?us-ascii?Q?cQGztCVMBRu/bI5gfSlxhbwus1keVlt9oGFmKP1KseCuvarQE+yFm8rvihZx?=
 =?us-ascii?Q?OFzTTwX1CtsCyYj1IwtgvoHEzlyGQ9ypGipqVRkx+9fXY6oA/m7I5nH7jEy5?=
 =?us-ascii?Q?tKSf0dMcBUGkA5bAr3GF5LQCRNNAlYg9/RK0mqg1QAdt4kd6PsOYO+72eeBF?=
 =?us-ascii?Q?8q8Plaplm8sUHHLFgk8Iu7U9S3xMEWHHAa7hUkbeUgFj19JFLKz/iMaHHiDO?=
 =?us-ascii?Q?M1iPypnsDwrCvlylXolEv+2+nj+D/PJY0AD2JdyFpoj1Q4plIYDIsStt1CmY?=
 =?us-ascii?Q?gi8woqbaVMIoz2ZFmAzwC0KG5cd1Y6AgGqybUCrNHl29i6/N3ZIhObtvMnHG?=
 =?us-ascii?Q?KdmuBe3P/ZtStxEMvkAWNoFWfUnAs2kZEYA5EJGkH6lJ5QgbJsZ4JhWrcNyL?=
 =?us-ascii?Q?hviC7lNiAqqt9h3hhNsjtzvxbjA6qVsEAIT3pzYQBcC2ejN+9WuGZo2HH6xm?=
 =?us-ascii?Q?9dTKg3FssHEGAiu6kOM1YGIbaVsjy9N0OmK7WfzJSNgtxUharu1OghnJU+xm?=
 =?us-ascii?Q?/iI7jUJxfv4i9yScR9vV/I+MNamfUuZOZdzHbRv4CnpXOsYlgbKal5/0fQKx?=
 =?us-ascii?Q?KKmO3GUXa0t2k8dQ90xbO20CjCXmBX/0UyQcDKOAjR0jg9Bx6PhO47vJktQA?=
 =?us-ascii?Q?yXJzueRpt9f6r/U2bq1fbiwCPYHuwr0bDhsGRK01b72r9yo786iSf/+mXEit?=
 =?us-ascii?Q?HdIAfvXib32C9pdfHEoeNlOpGSx5SSi+lJLOEX+mtvczs26dr6lDdc5pxR8s?=
 =?us-ascii?Q?rnJjE7Y6t1GFYXuBveCEFcZAJNs+SICVH4SyeH6ljbdGrpExDtQzXbaXkFmT?=
 =?us-ascii?Q?Jl/dpGjVpDFe4j/iF5O3tRrW5ftHkK2TskVZtDo1XXFrNuh78Ew/f6E5C1Xn?=
 =?us-ascii?Q?7l+n5GW5VWvWDRCH7w2fLs19wzIaGVFY14KxLwh7X2DNMh8hhOCVetYKBxFH?=
 =?us-ascii?Q?EuMYT+0+CVlgtQUAw1ZxmMfUoCjmO+Wfn51y8eJ2Qob32JpxYhL8k0+xBtok?=
 =?us-ascii?Q?dfsJ0gJkn3t7jxdw+35/NdFp8+NktNaklNsTAZdKpNZW8lCCPdvqI3h2kD/P?=
 =?us-ascii?Q?3kz9wIwMCzlBQSRNtuUU59CucjZ+cBiMNPbPtpBe9BY2oYKLHy7HOMvl7guJ?=
 =?us-ascii?Q?Q7UF+uB1HExJm4mFMDR3B4r8v8eb1Jn8L/KXTAxCPhlrI3hZqu0ACaruNmH8?=
 =?us-ascii?Q?n0zQ4Exr5AI84pUWDG2ER/2NUjFglDgOnynrNAIauG9lf0ic3N9oSUvfeWZl?=
 =?us-ascii?Q?nCcW1wzXxh5MmVzt5IRL5coF4HqX90RjXdEYGdK6KVAmshpl6Zsxsqbf5bdz?=
 =?us-ascii?Q?8M7IkMHgGGeW878niXv1E4lVIqNEROAXssLeGPIxuXEr3j+PnZBJptMw1VZm?=
 =?us-ascii?Q?/+ErIgRrW7W4rP/3AJzLwm3N18T8omZUGQ+b72waQUih0cFfL9+WS+0h5qyd?=
 =?us-ascii?Q?uE2GnQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dace52-6504-4014-5b99-08db7813cfc2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 20:11:08.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6veViruY8wM+f2nJUERPWHHCD9I2a8aVv9lfF8EQSH89b6BJScMIBU8b3pQ+1671xCbJouoA2HoqtXsHmstdiGtHANjnPqdiGJ7ZAi8Zy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4565
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 28, 2023 at 03:57:36PM +0200, Alexandra Winter wrote:
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

[text from Jakub]

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
