Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E9AEB64D7
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 19:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFTTRq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFTTRp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 15:17:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01B1704;
        Tue, 20 Jun 2023 12:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncSNAiE5CjS2jab0qAmAYn/aGkMaE1zRreogb/4zp2qco2oelmVFJdKRchQix+HPEXEw2PADbqls8c0uH5uefR6HF/U8cxzSBl51w/I60XRnqFssOEtm2gDjzToPM25bZMm+Ze98lmFo6fEdVetcpx9UGOKOqF9x3Mop83yij8EUcD+qDGjmp4eDGqTQsmvPqPZNkNedLFElYVrfNV19yZC6wpgPYoaRgYMIwqASlQ5rbtCok3rKf44e5yNg1L1/RwrubL2sFKMau1ogoXXE7vaW2D321w0LJGKr1zVVpFkqrzNSh2s7W9zFzoVWjjtLSFx/cLcfHO3oCeWcV93DOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IqRb+GvS82FQokEmxNFWXyX5dSRW7OeRiSA+NzYXrM=;
 b=Fnr6UmpnkEx8dxAtBHD9IOyovxcVYkmUi7zD0AkJn06+7emlfLSFEWoENJflk4YOPiOmZ26LzFJoityh8nmV3RLq7ihO4us9WFQsQ10xLEubpWal+HnPg4RHlka0G9lHf3C3a/NGcR5k1vNjDuJR/icEGHoU40hRZBszx0OdKRYeX/cV+7ppTxXikHyRR5ego/pIXjY9W7yAUWYchltqfU5AH3b6z1jM1ZNq4VnAAcyN0NTQQevyBypP+lNWQbOldl50tbj6upG9K0/KZJZo6b7oNpKyygtbzZuoVw4uNnLLigRaimp4dHh0wbidbphE68E3vL1wB4OHLqpL1egdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IqRb+GvS82FQokEmxNFWXyX5dSRW7OeRiSA+NzYXrM=;
 b=KC7yFCOQifLKf/w8l77KB/oLpoiDiLdIYVv0b5hcGaSC5QuiwowdSxZAKFqaSqDnqFNW5YX8nRJX8Sz6AX3O9yDNqLbmc761OV6gsgRgPdF5CBMEGKMeZz+C8hZQvD2KJCQ5Duos4CjxIJ3fBK+quYXQZeKgYgErwlKRUaOJo7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4668.namprd13.prod.outlook.com (2603:10b6:610:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 19:17:40 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:17:40 +0000
Date:   Tue, 20 Jun 2023 21:17:33 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH net-next 1/4] s390/lcs: Convert sysfs sprintf to
 sysfs_emit
Message-ID: <ZJH7TY4yROciw7kx@corigine.com>
References: <20230620083411.508797-1-wintera@linux.ibm.com>
 <20230620083411.508797-2-wintera@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620083411.508797-2-wintera@linux.ibm.com>
X-ClientProxiedBy: AM0PR05CA0086.eurprd05.prod.outlook.com
 (2603:10a6:208:136::26) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0492d114-84b1-4f6a-3e78-08db71c303d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzT+UpGk/Ek50vqfdjTF2LESHuzHXAPoC9I+B+xIy2imcWXQeoLKtJTUXcFv2dULtSayd1qjhyvBxExGLvk9+MmZwVPMiqNTsFLcuw7XwQOA78MMisuy3LqMmKSDMRaeQPkInAravFNsHuxlER+qsb1wmaFNaaNKfKyP6dYZxMSFO2nOtaFp73LMwJHVLH/VcE8wDEdRU7FEykop744Db/0AYNvIrbq+o6tCTPIMRLY3APqY2OqGcQS6EvdwSYt/Y2xTNMzw7lKwwPYq9hOtkpr1CbNAu7JDdbYm12vxfyQXO+E1JOBb1DFuhylIRxKttxOismPI9hQR9pCnfuDK54ff51/KrGVEMacGNgIYd5aHcoZdtd2smMBiribfnzAH1QAq9c7cJgtM1iWn10lXhzMIumFHtQd2xj7IvJdC2PsXxqXGVZFGrbCpgCujShk4ivxmSQ9MhPAKskgBQqwHjlGv6t2pok8L0K4NDJQE6GiyGh5BNT6RBU3hgieGku7cskPygZDqIjcF36UQ3z3mwHqh8YFboViu42Zm0Lfenni0CjSdBB8KiLlBZ5Rat5z+ihvJG8w9XvFa+DbaAt5hSSA4BTj4mJZZLXPWSHK4oTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(366004)(376002)(136003)(346002)(451199021)(41300700001)(5660300002)(6666004)(54906003)(2906002)(4744005)(316002)(7416002)(44832011)(8936002)(8676002)(66556008)(66476007)(6916009)(4326008)(66946007)(36756003)(478600001)(6486002)(38100700002)(86362001)(2616005)(186003)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3Fthkp5+4uJxNMbvwzjwrDtYw0+ODiUwFXSoupfPt22Su2AwzXGkIW3U5NZ?=
 =?us-ascii?Q?HJYhIEXA0/pHfLAjjpujEMTK4L2fkJZKkteweFCh3NePdizgI5+SLBdGz27H?=
 =?us-ascii?Q?PeM6bvjJNF2JB+knQsCxjEBEBJImOYlrfYP2KdS9tjDO+trOc6ueixRn5bYJ?=
 =?us-ascii?Q?aQ+XQvYuS1EUjWpmI5+h0vATBhgKgeFV6g4sj3++Jm6GPSRvyJnfCff/8kw/?=
 =?us-ascii?Q?jyYAHZniBSJhyD7lUOIpKEm0Z4KRnY0QvuRyad1Mw2EiNEalnwFcB6C4YPvf?=
 =?us-ascii?Q?BoAJX0usB1P7z9YyqumlsMhFKGndfO974KMevcbLBBJLHjDyuKxYjEnnTDSn?=
 =?us-ascii?Q?zFw5PCetQf7qc3YHxcBOSCCpnsJD9MpPDsYcZc/wreU0PsUJtug4zULz3rqy?=
 =?us-ascii?Q?3h4ZmL7hM/fbQ4+/exuUOZq50WfBoQS0dBokQxE1w868cMeGZYJgi0EpT/n1?=
 =?us-ascii?Q?SitxHQYxS01ZI8oLu2hQqzFEXtwJ8/0KL94Yw6/3z5UiTuisLlCsZfeMI4W4?=
 =?us-ascii?Q?3IWVuc7qx4TKvXjy+rr3/NNouFmIIjXOm7QBmbNCucXhHqevDwU+krrTUH3e?=
 =?us-ascii?Q?g97YOnrxHtzyGZMQvWJF63hWmNmumAxQVqqO8YFBLr83wa5cnH3LGyx+s1Bs?=
 =?us-ascii?Q?w84+CgedNuncVOkKCD/DUi1l/rtHVQ26Wc5hiP7hXAgclZwv2OUdBiYnz/uR?=
 =?us-ascii?Q?65/2OyD7p9auvr4sWFPVTS0X8vYM7x5AOptmp11MwliFXsVOXbIZS8S7heuj?=
 =?us-ascii?Q?WKLRp1W5/bhxWI3NDoZAUlwKTKu4kKWKiRQjjqRvs+Etgo2pnc96lNs6fYeV?=
 =?us-ascii?Q?juB1zfgS5URnbwmN/DL72J5hwA4vsJMQ5B719suvYV/XMYYEFVToJ1WOuKaY?=
 =?us-ascii?Q?g4FDZk81MRhczzMTeQiJbhVd0hzY2a1is2CegZzrlwUT4T8i0gr19Lf3hTlQ?=
 =?us-ascii?Q?6t9mlgzHdZjtoVQMYK7mNEW1UyQJpN4T7eNqqlaXRhqv1nW3BQvZSJKOEN2l?=
 =?us-ascii?Q?mGsBQoYs8my4OO0+Rg8p2J2a1LYsoIV4rk7u+bUXk3Sc8BJv1ERBSURSTksi?=
 =?us-ascii?Q?+gZGDItTtg9EVeyuI7aauObLVL4P7iOReV5qbndrbHGYaQ4O8rcSRAiJRX7F?=
 =?us-ascii?Q?IWvjPHHIIVzWu+3PrffATKZNwgteRmYonfpbH4+jONLk75/xBZ8k90Ao121B?=
 =?us-ascii?Q?U65ienqi+1Od8BsMscNXj9tjIllAw6eQy7MQeNcEjYF0hGc0IH9dFMSBgUMY?=
 =?us-ascii?Q?Iv2N+rkl8vV+d/+AcmTQreJ5uea+d/Jo6qZPqC1pXsBk3tACvL/KabNJMgIc?=
 =?us-ascii?Q?WqgyoTN20v5AYBwDdh/wnDIZ6PV78e+RoLnyTDnYoppTpWWMb8v2BoPO09ZM?=
 =?us-ascii?Q?9yyE3GMPs6WKjxJWupunQXzuLXGL+7tofQCBvkq5B8beM6SpzOb4dJ5ek0Jn?=
 =?us-ascii?Q?dbkZ10FLT+XjtBAAKexgRTzNnNo6/jBcs+e7X/nXcxGw1dLG/P+QRPLw1b2y?=
 =?us-ascii?Q?Kdym8LmnCLgxCs95bqXnNbkAohSthhbeByrVgNlsgtiEj2j7yyn9gROYqqeD?=
 =?us-ascii?Q?WdzGLdnpqlW6XSjDWz0sdlwWLETlKkC3U0rLRNfRR22wpA0G3lYITtL1yuuS?=
 =?us-ascii?Q?bUGgbgVb2cFFXLQbpoBYHUDjIXJcebHa3h28BxUXd1EB/Nxdwue9B07H8IjG?=
 =?us-ascii?Q?CgE58g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0492d114-84b1-4f6a-3e78-08db71c303d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:17:40.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjPU68oxuPTsr5cQelWqd0CaEzTVB5kIAEFTcJB0NgCcsznEJ6lT4OPTbG9dz9mCd9zp/kTL3tfkW522b1dtmWvVclI8dHgDHdKwgeGkLGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4668
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 20, 2023 at 10:34:08AM +0200, Alexandra Winter wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
> 
> Following the advice of the Documentation/filesystems/sysfs.rst.
> All sysfs related show()-functions should only use sysfs_emit() or
> sysfs_emit_at() when formatting the value to be returned to user space.
> 
> While at it, follow Linux kernel coding style and unify indentation
> 
> Reported-by: Jules Irenge <jbi.octave@gmail.com>
> Reported-by: Joe Perches <joe@perches.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

