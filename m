Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C8EB64D9
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jun 2023 12:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF2MIh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jun 2023 08:08:37 -0400
Received: from mail-dm6nam12on2097.outbound.protection.outlook.com ([40.107.243.97]:56592
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229539AbjF2MIf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Jun 2023 08:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrEteX0K1K8wUWsXf8gFnxvYz7LGEZY7vfk6xMXIrthJDxD42OTEzXGnZx/4cKtnaDEfVGUJ1dOjMlEs3Lgf3AUQLQoH6FidiQZ6moEUwXt9Yws8b3LgwM6jWrP/rIsdqlgrAkWgScmxJk8tfPNdl0wtwbUtt14Hui3+FGcx3zba/W8UENHHPwNT7xsrExrS9yQlnhkfKrWyuCTfQjbJE2jaSMh4mfWgZ+vSjmDzyU9iKST2/kVLStBJmLH8zBmUNWz2ViEWBeK//hIqWzegbc37wG7iDOm44AVggSN0rioCLY9iH9xJKZBAfBbRRIapD+wYV8teXX+VLeNML6HL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veQ/sK7pMz559Xdhw13YwvlglzWVjVi0JmJzQ2C7424=;
 b=AElrQYUDVLIip3uJinghFwXnYu9LCRMdXlQJSH56Oql5BT/x6T+5+OcC+YFO+Dk+dZmK1wOYtK/7c1k9vXo5yOO3sctuH6M8tUvg8wv6TMJhD0rqKTusSqurLhJ9k4WvjjiaGISYm51IZXyd1vxlYOIghhUCM7CPXmYpGj6KOSJsA6bpYuOfnKN4yRzKQb4ACfP0IGSZV9huJPly/m/kT7IsJ6akc2xMMqckYZSwdmMVPtq54nnEyYH6jk3jDEl6XoGLRa9cZQJ08XDIXQ2uzA0OQ3ZbzPa6XKfTBzLzTi4iTjKFDI6nlCwBYRWrFZH3Y9rpoMrgfZ8NOFGTakeCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veQ/sK7pMz559Xdhw13YwvlglzWVjVi0JmJzQ2C7424=;
 b=lUk7Krx0vxBv8++4/HTBKDlHI+9/9tV6nA9+rfhHSNVSuvf3Td5UsY4PHolQQPpdIduAMJkd1NJtLeOglvpD6U71JFOWbfn0KrXvLXigjYiccvQlWskKHJM4sVG4WvDjBtfs3Eyl74XY2TNYHaPI8zyzmzkNn8iGc/QeLgYQX3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5990.namprd13.prod.outlook.com (2603:10b6:303:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 12:08:33 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 12:08:33 +0000
Date:   Thu, 29 Jun 2023 14:08:26 +0200
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
Message-ID: <ZJ10OecUYdShN4kW@corigine.com>
References: <20230628135736.13339-1-wintera@linux.ibm.com>
 <ZJyT1aWFGqHjxofQ@corigine.com>
 <c589f29d-5ce5-9fc2-1a2d-3e5181a14bdd@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c589f29d-5ce5-9fc2-1a2d-3e5181a14bdd@linux.ibm.com>
X-ClientProxiedBy: AM0PR03CA0031.eurprd03.prod.outlook.com
 (2603:10a6:208:14::44) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c3eef6-2027-4330-0053-08db78998f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7qBJeUVeX093LCWIa16SBWTxJVi2pFe97SldJbpnhY8FvEfDkiqVaFFyrBHTJjM/KY02c48yQ1GCZacKbSJFr+RYfF0Yq6b2pcAeCc+auy/LGEpUbTqq9fYU9jcN93mCNibrTwKEuGTZ/rIHtIXAHGhP0zEKr/X2GEQRRyLLlxRM5zNxJP3tIsULsBP2bnafvDZEl2+nDM1RVxdbrtsOg8vkL3+352C2+xFSsTiT9ZUe6hYfLMJrA3I3RrCDXIEOEL279vjV7U3MoXXM0OcI5luvg9Q//F5OfEelINZ2ytuTPeCqu/2IVdtfvJpthVLrqrCD9JvTmXpi0pqIdb0tvKXDqyYDT6afvFrurMzggJZqP6RNy2fSNY2eofLtIQ3gqL6ftZKHmfJUUGig0+SO+lBAfbhAe97RKL/x7G9IBm3Vef4l20HLdxqQ33Hc+5VfFvFfSgJbgzjpA3DTUtlDR2tLvtb52SQSUX2LrlErnF8O8DzhihVlSfVHR6eluzsNcICiuOUZMW0vAFlrciLLQsNG89kTq3NCLgWmBpqIeS3fZ1X9mrHVrN/SoXgaxmb+X8pFDxuLlT+409PcGHWZx6vcxwo0DlTIdHzZUiyuHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39840400004)(396003)(346002)(451199021)(53546011)(6506007)(36756003)(66556008)(6486002)(966005)(6666004)(54906003)(2616005)(83380400001)(4744005)(6512007)(186003)(2906002)(478600001)(44832011)(86362001)(316002)(7416002)(5660300002)(66476007)(66946007)(8676002)(4326008)(6916009)(41300700001)(8936002)(38100700002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iylXuKmwt/vlFUYiKqY1QG5kbEnfYNKTm7cTybf6kh1ABogtlbSPiUlkQ/4B?=
 =?us-ascii?Q?XIlU02fSXfAGg5pOnUSwlxaJqToB8ZtuCvxgkVttY4L/DLpk2fW0gQY63HdU?=
 =?us-ascii?Q?vrgK7ztiHUgbvFjXNQ1abgi4EiwPYgG8O8ktf/ExvY72nl8xqkNK0/SjNlDP?=
 =?us-ascii?Q?vpTrT1grpU4IotAUVSi5I1LkuJbqXTpQsDXgDEsxeRI7/jkSjQC4m+RqyoSB?=
 =?us-ascii?Q?mP/nfU1zqW7itp1w3+ZIH8WStdBFA3Sp2LkxAVmiEj6mCrIpQvblQUW7trFc?=
 =?us-ascii?Q?ZzCRwEaW98bmCf8Ug+61OFSjMHVehOksHTFfA6SxCWrfsvIyNF7148Z8lpBW?=
 =?us-ascii?Q?tqeCLOa8U2cZUypXRa/RohaierrGvyWQwOobCdeViBtmpQlumIuQ0DRWAywn?=
 =?us-ascii?Q?AW27S744iTWHC9iH947tQ3W3Mz6qFByMSX4iQfFA/Y06t3fAhVF6U1f/C/dn?=
 =?us-ascii?Q?9gVBhJiek1XW+/YsyUG4uNCKI5Za8T93rwhqXo5GX/whLEoQlddYvKmsCDQv?=
 =?us-ascii?Q?t5tGu0MCZ+Emhe+4k9JjTEvPjPrxPbgPPnoPsZJFd2Ky0GHkU4tkRzagZQsH?=
 =?us-ascii?Q?rs3CZM2L3FTLRh8NllmIJTLSk6kw5To7aAOwvowAgRjs4xks8tafMePdtH1V?=
 =?us-ascii?Q?qe1yshVRUGJiOZQxwU0moR+FNZYDrP8N1wjxiq09yBYSwIQkeTejAJYSbeNH?=
 =?us-ascii?Q?2RkbzLTz4mDlKp9BTvOivAt59xfTFfY8CD9oG0UcLSoJHe0gsJKBdIZ+1T4W?=
 =?us-ascii?Q?u7+36J06oMoVnFKjyY4T7li988qzrcryz32sGCuci3YbFrDXJ067tpKqX1A4?=
 =?us-ascii?Q?ic1HZPnWxclJKxRMOX95VyBRDxoIwXtjLSa+NQkw7C4FiCIeTa9ixHXCTNZ7?=
 =?us-ascii?Q?oHXIK3aUPgOWh/trYNQ5mB+4QayFOQsG4iycvkBBc1gIvSdnZLfzq1ftzfn1?=
 =?us-ascii?Q?N+DeEBCU8ksfdxwgvTicPdISioJ/uycJB+DoZIECQYGvuP1UvGeCiebn+Zp5?=
 =?us-ascii?Q?jqwJYBgxqjxzvj819lpqxNiV9ibYAslJmTMf1I4Jcmk1uRmaJjJqTLoiPHGA?=
 =?us-ascii?Q?CwBTlFuWYE+aTlcASz1Tyyu6LIawqhNHbJmc2sbe48W+0m+u6KOZGYBoRvkM?=
 =?us-ascii?Q?+DdaJiBN3XbHofxtzo1Ig+pkUzZJgYZFRmMcD9keDLxMVtLjzlmG0LR3bfs9?=
 =?us-ascii?Q?su6VQxQVcpOlkzVUxSfy3KkBKQ3DmEAaCrzxHDEsGrUacV6Z56jg3Gyqz54Q?=
 =?us-ascii?Q?uXW0DhkMRP8cQF/wxwuNqEI17iH5dbMTMvLOiNONyaiUkW2vT7qs/UaLRy5m?=
 =?us-ascii?Q?mlXGD9kF67XOsUc33zcDmf7ANPESo1RfwubFgSPMcnVCPJeRtAYjoSJ10Pzu?=
 =?us-ascii?Q?9cIFbuR9olLAEMsLQ/QHtltkfB6tQvzTv6KOcNG0R2h94pTwa8oYMk5jTnIj?=
 =?us-ascii?Q?2PS6uOkKxvzP6DJsJcAy2H/hvAs/uZ47jW9Waxg/MR7eAVRLeKqKDt8ATJO4?=
 =?us-ascii?Q?kUgP2e5GgiBvS3y0G2ivFgxrug184pmR4anKTCWqL40fRpS76K9yvIO0wr1z?=
 =?us-ascii?Q?HfNeNt3Y+hAfdalaFpvohnfZJQY8E1u6huzjoZIxxkVE8u9Dltu6TcS3Sxm0?=
 =?us-ascii?Q?vjCClEk3oacvr3Pcb7FzQgMUC8QHld/xjdpl0VyKF8MCpLPdTCn1WMS/q5Dy?=
 =?us-ascii?Q?maqhXA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c3eef6-2027-4330-0053-08db78998f4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 12:08:33.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PWaO4FehDERGLplU7GxInxdlO5YbgcY9v4uSLkhmUcuz+kzmraAkWohGGU06zwvTeRgJ8A6jcM7HoCQZLwVI6mnu7RBKSQfjQucotJjQFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5990
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 29, 2023 at 09:59:15AM +0200, Alexandra Winter wrote:
> 
> 
> On 28.06.23 22:11, Simon Horman wrote:
> > [text from Jakub]
> > 
> > ## Form letter - net-next-closed
> > 
> > The merge window for v6.5 has begun and therefore net-next is closed
> > for new drivers, features, code refactoring and optimizations.
> > We are currently accepting bug fixes only.
> > 
> > Please repost when net-next reopens after July 10th.
> > 
> > RFC patches sent for review only are obviously welcome at any time.
> > 
> > See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> > --
> > pw-bot: defer
> 
> Thank you Simon for the information.
> 
> So http://vger.kernel.org/~davem/net-next.html
> is no longer relevant?
> (I was using that page to check, whether net-next was still open.)

Unfortunately it seems that page sometimes gets out of sync.
