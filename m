Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D84C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C2760EB4
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 14:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhGWNWB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:22:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6842 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235342AbhGWNVf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Jul 2021 09:21:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NDpP0a022557;
        Fri, 23 Jul 2021 14:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CGhI0ji+Z5SS8FkdKXLkX2AtilhqGdtMRKronU+8NFU=;
 b=nxTkQnQdD2z/cBVfPTP4uB/RztJ4w4ZedgcEv2EVNuyulOI9t6NisaSVjxUYzyoIVv3p
 FH22vi5HQ0kXWptN2Q1289W6ZrxpT4ZO1fZIGiM5oxkjwPKUNm/fvyHP545J6vSe3sxA
 3FAUt+PLi5zBa8AR3So5fOI5fe8y+N0FxPMd/vSu3T/LnJAqNIu1FgzXBvEPZu8pu3MQ
 N7r2D0i317BOzuSVFxniALGvChjpNl7jMa8Mcsaq6JUAKVd3HZNZVfAAXlIzXmnQw//C
 uRuDZALsYfnrB2Nv8StCDCUIOS+Q5f7lT+EW/z5XEcj/YKB4I7k4fSFME195uEs6dedb Uw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=CGhI0ji+Z5SS8FkdKXLkX2AtilhqGdtMRKronU+8NFU=;
 b=Ax7pqcCykB4u4cxh/pV3vuZhl9dpC+1iZ85xue4yZu/J9SdFzTyMWIPLBI2bI9Yoy8ix
 Q/cN4QwhInDiU3wYx+PbqgHUaH53tcdCMAA4LoGymAKU6LC4R6jFRR+99Mayv9ZdsuWL
 4gwP8Ow+doxzuTj1bTeHyNpBWWeQEOPkibdKvKcaLi8iJaKIU4s+tkfVXrRhW8C0CKXe
 SwWgN+tBE2YF0+J6IajXLipKO/6V0t9Ngv5Xh7gM2Fdyxm17PEVgZwCm/t7T3T9zsZlM
 vmFc0XIFTxAiMZYnc0yhXbtz4v0td0gHSVXb9bQO4YLAoBrN2GgoXBmuowxxKFFR/h1+ 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xvm7v0ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 14:01:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16NDpIkm111407;
        Fri, 23 Jul 2021 14:01:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 39uq1d9ews-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 14:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljc/TEXw4zdsxWXMqbkisk09xFelVuwhMO3DPvz0dB0QjAEbdsxzi1UwmMu1X043ivAti5FwbU871h9XPfQGY9NxOAZIXUVsUMNIBz8g3gxeudr6m/Si2kBTqaph/dUGrPgqlaXFwmwS5j5QUdgruqwQI6Xq4RdENwaWPvQZyDvTENw5pH89pd9R55cWZr+j8prRcVKSIq/cvzrRfS9amDgcVsNEwHofDNjdA+UtnWczLVTUydEWKmf0Oqcidr7vC40K0QeWvrJK83qAix0zDQNlnYUC8M7qi/dcpQsBoJHrtQlcIWPoN0orqKErrnMef3O+1rPratXWYNnUDOdh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGhI0ji+Z5SS8FkdKXLkX2AtilhqGdtMRKronU+8NFU=;
 b=aRFKVBjev+uJlmz8uYSSlOKsVWWMnU1adal37mDOBqXCj8mY3nh7u1jvChbswNG9GkdrBfK9Xv3u9BlIa8bdaSXbdt1EOAs4F24Wjn9qlEA2jIy6GRpc3bk6pgG9LVz9Qsa0cbntanzhuV5gwK7FhamFJJ7wTOnkUUHXwrr1EuvjSGpUXJATTCruWO+YY4E8Ojg2VvHhdcVQNJ34Qut9AS2BgdUnbQVmWMyok4OUxAB+JGYAGHQzkSfzYTGFIqFiwSYd0MFM8I8sM+Q08Y3ze9IzBe2A06fOjctx/Onv2qxdgx6Hty++kceGvRNv+7LRtRN/xpF7WcCfLSAQfks/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGhI0ji+Z5SS8FkdKXLkX2AtilhqGdtMRKronU+8NFU=;
 b=PBFb3QWykza8oR42uhTinckA5MuTcMuvskDqIsPBZlUdKSca53fYebDKDi3pajLZyRnrD1LBak5ImcorSFdPxTmYFwMw85y64ZYM2M5gx9135Yahikf5DB1gU1m7OVqk8WN92m8rK30cOnGfM6afmAuVcdBupdlZRYC+jkduQi4=
Authentication-Results: de.ibm.com; dkim=none (message not signed)
 header.d=none;de.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3988.namprd10.prod.outlook.com (2603:10b6:a03:1b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 14:01:38 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 14:01:38 +0000
Date:   Fri, 23 Jul 2021 10:01:29 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Message-ID: <YPrLualvV9/lE41j@char.us.oracle.com>
References: <20210720133826.9075-1-will@kernel.org>
 <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
 <20210723031252.655d6a83.pasic@linux.ibm.com>
 <b8985c53-a83d-f11f-9fa8-af06d1d4bfd0@de.ibm.com>
 <20210723104701.3f8ac227.pasic@linux.ibm.com>
 <ab29cae0-2c1d-354a-5213-9fe4159570e0@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab29cae0-2c1d-354a-5213-9fe4159570e0@de.ibm.com>
X-ClientProxiedBy: SN4PR0701CA0026.namprd07.prod.outlook.com
 (2603:10b6:803:2d::24) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from char.us.oracle.com (138.3.200.10) by SN4PR0701CA0026.namprd07.prod.outlook.com (2603:10b6:803:2d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Fri, 23 Jul 2021 14:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac5075f-e250-451e-2436-08d94de263b0
X-MS-TrafficTypeDiagnostic: BY5PR10MB3988:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3988ADFC152FADD2C0E2639889E59@BY5PR10MB3988.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQycqxKQ9n7orrK5Hzm2QL9Rtqopj3910gzLenPlbD7BVuqLQ5mrv9vaDvk57302iF3fpj/CEnc1UUkMPDIKiNv2/II7PRPMxcdIJnLSPyTKTwnpYda7UlQtjrSK5HPxjqVsN4ebO4FJrEiDBN/FCLupKii3PhGnwMH1bk/tysRyg2JGX9BMVCe5UmiFN288v8SHvjVzQqpuTvuC9jqq6hhLZfAAj4z9MJBp4hpIB6OgglYIJXi+7tENBmRtDJtp6W2mme9j1cyFD67n62uuVBOmd2qVkHbAfFdMMrBaGAuPcmCRfSSJy0sRfdFTqtzMfm1rTJ8CsOz9HypGyfO5IpAO+L0uth3cnRqxZ/xAvGVkW8NnA7qba5TL9MJ4MPZJ/JAY6NqM39Fl6i1nRCEsWkBhJ1p6rFpHthyfhmGS5N+cQHJWRlXojBrQWbk8PL0eVqbMup1VelemW22NY5uDkej7QjiY7Vd0pfKS6R3FHIGrXm4xCffISzBY21Pufw0O/Hcj1IJ+mkitYAta8lXxy0foQGH6rQo9mtu9z0XR0SZFaJISN7B4JaiHMKR9SCglbN2vZ8/8EJlNq8ll2/8TURlxT9RO+okY5LBdwBKKT2wQ+++mggboKhe7c4UmktArsyq1aBX5Sq2GY65UsVOlEQDQhEOWPSxn04gKnnVDvkghX6FlltmenV67oIn1Stlk/Eulm+Cdr3JwW8E4qVsIyf00PLFD8NFVABd0n5kunBI4kg2lowxfYQ8XldpKGPXRYid3AIGz/Ngq9RQM6dy4xeb2FyY+JBvHry6DPQ0IOe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(366004)(376002)(54906003)(66556008)(66476007)(478600001)(6916009)(55016002)(66946007)(8676002)(8936002)(6666004)(5660300002)(7416002)(316002)(26005)(186003)(38350700002)(4326008)(7696005)(52116002)(2906002)(966005)(83380400001)(38100700002)(956004)(53546011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGRrD0H/NE7eqL33oq5t39BTHmt18fDSEwCS5S99nabjfaoikjiANANUh0xG?=
 =?us-ascii?Q?75s25xkDysX+OHJEEhLY6Z94RJT3FyG2Y3Tc9RWk+Kp9CbKcUNC6yoB1i2K1?=
 =?us-ascii?Q?w332cCVyRJ/6hcgr89CqBRdN4vNgLk9O0LHmSCchqLQP9QFOuXAnqQC1yJdW?=
 =?us-ascii?Q?3DGXFT3zzyqLpwibwkRvKvhaBKIzyD+YvBHsUbVAR3owqqrxwftdW3CrpgVU?=
 =?us-ascii?Q?IcuMts3DnWqWp8PAQyz43hiiTuzbYF4SJMPIOih0mfekDGIFsyhKADxtjamt?=
 =?us-ascii?Q?VUw5WQXVMMy/Z2c78j8CXn9M4R81p3XB8HQkdbyLLZxwMclt0m2Ztd4bdZ4y?=
 =?us-ascii?Q?GXbQLg1IzALou+ZKs4Dgz8qJa32yRfMid2IWDv51fTH4Uy+DSjbhg4NOLg4n?=
 =?us-ascii?Q?g5ZeLp2i2XKSOsmi8OUPNpw+4zKQ83LHdQQxEbiH6M4sMG7GtQSiu/0TFfth?=
 =?us-ascii?Q?0iVHZgIgoSxZRlcDSspDxkhUmx+3c+B5puB6td/2mByqHKEGt8AWQmRRFMEL?=
 =?us-ascii?Q?aHFnZethIAcJJsoVagTTLRXpka/4ewfaaiFnn0DyfkPKfGaDQ1n7S491ph3j?=
 =?us-ascii?Q?gNdx4B+3rA5tWeDeBkTcCCtIs4kkqgRByn0zSuH0kqOF6KNzca/hxL5BUQVL?=
 =?us-ascii?Q?Fe3g0G+agMMvmsXK4L8WJNJScelb/UBz/OiJ2dXYv6gOqUK5kwzUbZ0DIonj?=
 =?us-ascii?Q?sU6r6pszi658+0SV8eQeeQ+5Fk99jsw8f/UT/YqeYlaynmqv6LTF//62Ew9u?=
 =?us-ascii?Q?95AtKnHCW2A9rMqzxZkpoKCwKSVPHV9AAi8zghX8toepAN4oO3x0N07DBK0n?=
 =?us-ascii?Q?6Zhv4idS1xbeKPp1+47PRQ7dar79UQ6RLJTg3WB7J5RUlbu9iYekxFAT6tKl?=
 =?us-ascii?Q?j7D4G0EVCaOmPYeotbOzsD46vMo6sOc73pubEs0ohmCuPC1+F2ql26Gn2ITj?=
 =?us-ascii?Q?oMRtEU4aG0rntPuyLPLPOOceFteuUVIw8AJHuo+xb6WjyTvB7NEz/sJNXOtD?=
 =?us-ascii?Q?zwj+wN/9HltZobj4QxwpGMvWjbl0ZIuc54cz3lxCZgqIDlDNGRYu40XRsA4T?=
 =?us-ascii?Q?uYv49TrjazDIc6+jhoigseiTyDZE76YSVsdulwHsfKYnBLGXbeehFY9zRFVZ?=
 =?us-ascii?Q?xi8GpphEFrvvsi4JkIqIplwbcF8aLiCq3riWgsLW+YM89OqeygpqimMOwiRH?=
 =?us-ascii?Q?XrRGyxsjbv+qD9KNpjs3Dm9+uk/FdbaEqKZgM8fFZsbuClHACYkuf13YdrzZ?=
 =?us-ascii?Q?Z+5A8B25XgU9X4eEIJaF1PgmRh2DkZfB6l3Ly600GicZHgvQC3vPT5XWBmNj?=
 =?us-ascii?Q?OXPVe0fxh2GK5dXWQQ844KmJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac5075f-e250-451e-2436-08d94de263b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 14:01:38.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyGCEWdveLQU2u6hsY+tGLn0tLQQ92JHb+dOvYdcAVwDF9CmvCpHHxgrQztmElZfuIDCYpO6iUcFjqUIXwYcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3988
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10053 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230083
X-Proofpoint-ORIG-GUID: pnBzPCIApr13UbnvFv2arzfjHgjOtEjC
X-Proofpoint-GUID: pnBzPCIApr13UbnvFv2arzfjHgjOtEjC
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 23, 2021 at 10:50:57AM +0200, Christian Borntraeger wrote:
> 
> 
> On 23.07.21 10:47, Halil Pasic wrote:
> > On Fri, 23 Jul 2021 08:14:19 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > 
> > > Resending with the correct email of Heiko....
> > > 
> > > On 23.07.21 03:12, Halil Pasic wrote:
> > > > On Thu, 22 Jul 2021 21:22:58 +0200
> > > > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > > > > On 20.07.21 15:38, Will Deacon wrote:
> > > > > > Hi again, folks,
> > > > > > 
> > > > > > This is version two of the patch series I posted yesterday:
> > > > > > 
> > > > > >      https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> > > > > > 
> > > > > > The only changes since v1 are:
> > > > > > 
> > > > > >      * Squash patches 2 and 3, amending the commit message accordingly
> > > > > >      * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> > > > > > 
> > > > > > I'd usually leave it a bit longer between postings, but since this fixes
> > > > > > issues with patches in -next I thought I'd spin a new version immediately.
> > > > > > 
> > > > > > Cheers,
> > > > > 
> > > > > FWIW, I just bisected virtio-errors with secure execution mode
> > > > > qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0
> > > > > 
> > > > > to
> > > > > commit 903cd0f315fe426c6a64c54ed389de0becb663dc
> > > > > Author: Claire Chang <tientzu@chromium.org>
> > > > > Date:   Thu Jun 24 23:55:20 2021 +0800
> > > > > 
> > > > >         swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
> > > > > 
> > > > > Unfortunately this patch series does NOT fix this issue, so it seems that even more
> > > > > things are broken.
> > > > > 
> > > > > Any idea what else might be broken?
> > > > 
> > > > I've done some debugging, and I think I know what is going on. Since
> > > > that commit we need to set force_swiotlb before the swiotlb itself is
> > > > initialized. So the patch below should fix the problem.
> > > > 
> > > > --------------------8<-------------------------------------
> > > > 
> > > > From: Halil Pasic <pasic@linux.ibm.com>
> > > > Date: Fri, 23 Jul 2021 02:57:06 +0200
> > > > Subject: [PATCH 1/1] s390/pv: fix the forcing of the swiotlb
> > > > 
> > > > Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
> > > > swiotlb data bouncing") if code sets swiotlb_force it needs to do so
> > > > before the swiotlb is initialised. Otherwise
> > > > io_tlb_default_mem->force_bounce will not get set to true, and devices
> > > > that use (the default) swiotlb will not bounce  despite switolb_force
> > > > having the value of SWIOTLB_FORCE.
> > > > 
> > > > Let us restore swiotlb functionality for PV by fulfilling this new
> > > > requirement.
> > > I would add:
> > > Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
> > > as this patch breaks things
> > > and
> > > Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> > > 
> > > to make the s390 init code more robust in case people start backporting things.
> > 
> > I agree. Do we want this backported to the stable releases that have
> > 64e1f0c531d1  (i.e. do we need a cc stable) or should the fixes tag just
> > serve as metadata? My guess is, it's the former. In that sense should I
> > add the tags along with an explanation for the second fixes respin with
> > cc stable?
> > 
> > (BTW I don't think this formally qualifies for the stable backports, but
> > I hope we can make an exception...)
> 
> I think it makes sense for stable as it is cleaner to set the flags before
> calling the init function. cc stable would be better and the right way
> according to process, but the Fixes tag is mostly enough.

But the reaso for fixing this is for code that is not yet in Linus's
tree?

I can just pick this patch up and add it in the pile I have for the next
merge window?
> 
> > 
> > > 
> > > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > 
> > > I can confirm that this fixes the problem. This also makes sense codewise.
> > > 
> > > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > 
> > Thanks!
> > 
> > Regards,
> > Halil
> > > 
> > > Konrad, Heiko, Vasily, any preference which tree this goes? I think s390
> > > would be easiest, but that requires that the patches in the swiotlb tree have
> > > fixed commit IDs.
> > > 
> > > > ---
> > > >    arch/s390/mm/init.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> > > > index 8ac710de1ab1..07bbee9b7320 100644
> > > > --- a/arch/s390/mm/init.c
> > > > +++ b/arch/s390/mm/init.c
> > > > @@ -186,9 +186,9 @@ static void pv_init(void)
> > > >    		return;
> > > >    	/* make sure bounce buffers are shared */
> > > > +	swiotlb_force = SWIOTLB_FORCE;
> > > >    	swiotlb_init(1);
> > > >    	swiotlb_update_mem_attributes();
> > > > -	swiotlb_force = SWIOTLB_FORCE;
> > > >    }
> > > >    void __init mem_init(void)
> > 
