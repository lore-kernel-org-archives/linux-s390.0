Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51645C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  8 Feb 2022 07:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiBHHPU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Feb 2022 02:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiBHHPU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Feb 2022 02:15:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AEBC0401EF
        for <linux-s390@vger.kernel.org>; Mon,  7 Feb 2022 23:15:19 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2184L3Ws011044;
        Tue, 8 Feb 2022 07:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=A8OnE/snrWBHdiSZhStz14sL8008I3sKMuUoKlgjnAQ=;
 b=Jcvm+7XObyE6qmbKIxWVpCq/pLj6P5zI7F+VNjOEIPvLSkcTIrM2iDLBWEHB13p/lPvu
 SeZTTAbjyNLUg4c0GHStcDqnPXdMaQ0+Z3GQHmF/nBl3qNr2Smpst+hO4Mc21U+0bos4
 s/yW4YuT562NchFsBKEdr2cnz7Jt2kRYfkrxhYV1k7x6wswgSzJ+FY6oYduGpghODYIm
 ZgQbSTI3Jncj4/amsXP+nem6zmNfZqPdCYfpUGVkUN/daU8t24wz2i2pNJN+XVDzh/Au
 hawx+nsfrnoewVFtK+2Hu58Is31Kl5mkepvgYX1JgNxRRw9MgVN9LiDwga6fQmRcttUd ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdsrd8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 07:15:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2187C4Bn159183;
        Tue, 8 Feb 2022 07:15:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 3e1f9en846-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 07:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnn9oIQlS9RzSWuPhgqTImFhciCczoF2IoEDmreePOQ7i+sqxJgCF+sbYTiLbMQsjks3SkFa6IVTZnL2rCoI/NLIbhQzaSheVCfoY0VT5ZLFbh8Rjmb22t2iHnfFMQA2PRyvgS2OrAWVrc2GZGMmVfX8jHwFRbk8PYX6uNEI+gOZ/hCOT8ly7h+abhnZER22WM/uZjJj1pNIin1UItlt2x8ACb1C0awjJusiIcJZkHjEklJGlWvhGdl6773FsSONab9KA2TXqVUMLfo4kJklfCGMyJKqP7D9JJNUZH+Dw9m2IvWEh1Tv1CuEZ3F2fWyFUt0TOlMWMaaIWTi+KFvPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8OnE/snrWBHdiSZhStz14sL8008I3sKMuUoKlgjnAQ=;
 b=XR60UOY3m13jM0L+UeYqONxWih7qCrBGVUirL66jZz/7WXgPpTXnCkeK6Nf4GeACzJsgI3q8nixIPM+4miGYQaTcADYYdiw4vQBLebjlVleRFugFA6iqpErKKMY3M1nDXoiOYZcPntS+jZOru8INZGMWSn8wxOWCAkJpmGjYzaC5ZBnZ3D85b33k37p/ZsPiSu1at8E953u62Ny+ymgUdXOORpAn5Cs1Zps5bZYRQUHBjrs81bldYng7qUgXLnPx6Oi08R+8bp0JHhUOkJuv3CD9LyBozSz2Fz2pDcI1ltlvM8IDJvhOmsTYgTJxIZRwbtZoH8NiENJLz6cMT5kutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8OnE/snrWBHdiSZhStz14sL8008I3sKMuUoKlgjnAQ=;
 b=av5X2UgBbBJYWw8hTimmvy1UV0JdZhNF4b++V2blJ5EcaTFGZYHfXi2njkjcFHZNMiEDUDVJ1oFV3w86LEZR5OXAUlxBEgcTZOtSMxhQ5GMyEfuk5YkaIrCWEU34UPGJz8e6VghNeUsVfjZJhLAxNtLhsW8xnkoiAJjISzj9vpQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1269.namprd10.prod.outlook.com
 (2603:10b6:910:5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 07:15:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 07:15:14 +0000
Date:   Tue, 8 Feb 2022 10:15:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     edumazet@google.com
Cc:     linux-s390@vger.kernel.org
Subject: [bug report] net/smc: fix ref_tracker issue in smc_pnet_add()
Message-ID: <20220208071502.GA10495@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0107.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ef6ca2-c91f-4fb6-e905-08d9ead2c016
X-MS-TrafficTypeDiagnostic: CY4PR10MB1269:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1269D82787A34072AF815EE08E2D9@CY4PR10MB1269.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz6pxPxc9sANVOF0hOqi9UHI9t46UXBKdCgX7BDpC8rSt80Gt54wpk6UIN+iecKYMKfqRlYOSDmysOGnUxPwKBoRC5odzPB8FY98yyfx2HQEKLLfWIF4iYgRTOiQf5U49qf2CJSDEnNVprVnBu9YiGD+BdcNIgRlUhQVymRZ4lzivFsaNpOAGuRsxhjf8SjtAURy2Z5JyV/Hsvx3E4atE0xIuL0wS9wKdAwp5vuDYdv9HE5q4/rb4ztDFRPiQq7DanNuZ2/mMgVw80FnaInDcQTtmiUvN2N0QW4sBOH3ViXjGAObDRpc5eaAiwORHkPwFwkei3ow4s6vM4BEfGLBOc3qwIsWa45MUHYhZAL+b1PcFPO2es/MH43BKgBv+GgG+K/igsYNzeqDASs06TsSAIOe4b4WaoTgmDcIX0ReRF92oqdjsvBAIw1Z928oiZNtziixFdc9K+ZYT1ZJJAyw7D3rcY1IgXu0t0sLHWpRIyfLJlplvt+33/eyXbURJAghKYEsMv5+AV3mhzW5ouE97WKcKrRC1JKvIL3WsL/zAESxlegbpK1wWqwxIaIbtdC/hWjaJUpAPncPVz7aQSx7inzjPnOClj970zzU7HqGSmZyPzyAYEsQ0JOLI8T6jMp5v3xfVqmCXtXfi7nRE0uuzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(1076003)(33716001)(38100700002)(2906002)(33656002)(44832011)(186003)(86362001)(316002)(6486002)(83380400001)(8936002)(8676002)(66476007)(5660300002)(66556008)(66946007)(508600001)(52116002)(6506007)(6512007)(6666004)(4326008)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gT8A1ndyA2ajryNZgYljw8bvCjvrcLuH1YwRaHX8UI6LoV9R7gRRBc0Etj2p?=
 =?us-ascii?Q?kFno1wZlLU8NY8ocKgVYPo9ToeJ4i1gtZmt1bxTScO7p34YkBUHrt3n5PCm/?=
 =?us-ascii?Q?SJEjgIMnjGsBQkaxvx0BNgJbHtvpOtTz2zOdXtS9nRt4EFOC3v/B2+mFXVfd?=
 =?us-ascii?Q?Haey4L3Nk3esaQ/fd89t8mS/jQdIJk4BhuugM0eiP4pl+UnrxsC8TvChLuMb?=
 =?us-ascii?Q?VC6Ln8WGS4EgSPqWFzpfcX7ZqRlyHw/9CneWTJ9v8qW3NDlaPgz8HoecHzRU?=
 =?us-ascii?Q?8Xbt2nvrrguKcOw6XFE/bg64EQUpAR6/RYDAt8nUhPtXKnc3uiazpXRtF6pY?=
 =?us-ascii?Q?/y4V7gamVNvGnZAlE1YjjMWio9keWawhMrMOhbcr0HQW8rhQPAZGBYKhI6ZP?=
 =?us-ascii?Q?GwGGWWMEK6rxYSx3L13gmULHQoo2NutC2e9OAxfmFKn7eoaqj2L+0/L8/cIR?=
 =?us-ascii?Q?+ZGgXBTPexrUtqIlB4jkBLOuh0/enJULKEoEwVPQimN4708nfnBewnZLtHgK?=
 =?us-ascii?Q?4QfRwAu56CF6P7dFsrqcY6N1boNIrrZMt+KqKl6yCCF/fAOWVf1XBtDPW4l1?=
 =?us-ascii?Q?DGegsIPYIlIrDL4dmnd9xGyM56qgTgtrca7wvkH9W/9IItdrci86gIjW4W1F?=
 =?us-ascii?Q?+98F1/Jd+q5iQSKP0f2H285hZR0sjak+sjnIl0JP6CUWvEfeanz0TlPu89Js?=
 =?us-ascii?Q?WAP9zbupP47o997PDem1oL7gUHOKFZfIwh/UCBlYf+Mi53/cQKzacYt2uNmF?=
 =?us-ascii?Q?gKgMgMw1DVhafWdnx+PsuXVy+lEBMzWzui80sVxAerptYd8+TUMdmrMJKmTs?=
 =?us-ascii?Q?OOg7VZRUUTKQT6PeNyMQ3f/mdn7pKf7D7Ktcn1WztmwhbsRJlgnjkBQHZ9Qv?=
 =?us-ascii?Q?3sfPKgm5QnXrjVO2n1ErLFzmG9Rm8FbXM9GoCUp4Zvgr/4z6iCqpOsOEjrze?=
 =?us-ascii?Q?FaA8kvG7m/2PDjFKfZrwFRC5YmY8tcaUyQQIEP46iXinB/Ols7pSgGQfT0LZ?=
 =?us-ascii?Q?u2XHRQM8peBhH1zE/O7sVmd2lxph514Osc4Vznl7GrGVpWFYWg5m/AJP7uDQ?=
 =?us-ascii?Q?ba+CccB9qx9f+za3D9IVKkl12gQg8Eui8BgepUIM+NfS+yJsiUzgmE7exxrJ?=
 =?us-ascii?Q?AD3eUTb4MjmVZkq6Y/7qq5dP+dgtGhnB+ky3J7Zlbn/zdR/AITD47oQoZsax?=
 =?us-ascii?Q?crceE3OHF5u36RVbrfHYKPp5IAvMbTgrEWiHi2N7tuNAPLmNB2Oo5uaOzlbS?=
 =?us-ascii?Q?YkbzKKWCpYnkhHMK9Zif6T1T/9vtCUTl/3cfHvMfcIdO5H8WX8z+x/gAjrzu?=
 =?us-ascii?Q?sE2oq2EK75EEm/4C2LYuPPb7jRLhKMymMfSBmJjc3qF/E066EeWOUCwavKJ0?=
 =?us-ascii?Q?6V7ydv4Zl0z2+5UjmoDQjV5tl0/pLwNM13Ps+HgQDuc2xN/xzBKcUP47k0RX?=
 =?us-ascii?Q?eQ/Ib0JA0fKC3KvvsyaChNqSyqYpnWQ2LIAijsqcs4UXNB2tJX30d0SbzvNn?=
 =?us-ascii?Q?hU1k/M/qRVmskKtQn3K+DOMZ7K4U7aE3YBsYUo3LxSkePAPxcLEYnog8cw4R?=
 =?us-ascii?Q?6uCE54A6SwbF9j2N6Pqs9cHx+Hu8/YvR8chocp8B+6xyhc9tP+KYBC9ezmpo?=
 =?us-ascii?Q?1oadKGy9zCDdsVqO5EeHQIGZmhmL2vzblEv8j3wwgicYam0RsYc2vbN0UR41?=
 =?us-ascii?Q?96RhWWLLyLP5RV/nZqAVL7jAsAT++q4ZS2nOT7FL3Hej/MsH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ef6ca2-c91f-4fb6-e905-08d9ead2c016
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 07:15:13.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+XBxoXJQTmzd2dXO2HAYKwnQbh5gSfyCfPENbSXpQSEDD3Y7TSaZ+xzt7xBYBYLnmCS3ldULIyoFmgGhIxT24Ahm6cde9ZFjHdinZFgQ9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1269
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080038
X-Proofpoint-GUID: CN7sYK8Vws2YHmXBIqRYgbzYe49UMZKt
X-Proofpoint-ORIG-GUID: CN7sYK8Vws2YHmXBIqRYgbzYe49UMZKt
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Eric Dumazet,

The patch 28f922213886: "net/smc: fix ref_tracker issue in
smc_pnet_add()" from Feb 5, 2022, leads to the following Smatch
static checker warning:

	net/smc/smc_pnet.c:384 smc_pnet_add_eth()
	warn: sleeping in atomic context

net/smc/smc_pnet.c
    342 static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
    343                             char *eth_name, char *pnet_name)
    344 {
    345         struct smc_pnetentry *tmp_pe, *new_pe;
    346         struct net_device *ndev, *base_ndev;
    347         u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
    348         bool new_netdev;
    349         int rc;
    350 
    351         /* check if (base) netdev already has a pnetid. If there is one, we do
    352          * not want to add a pnet table entry
    353          */
    354         rc = -EEXIST;
    355         ndev = dev_get_by_name(net, eth_name);        /* dev_hold() */
    356         if (ndev) {
    357                 base_ndev = pnet_find_base_ndev(ndev);
    358                 if (!smc_pnetid_by_dev_port(base_ndev->dev.parent,
    359                                             base_ndev->dev_port, ndev_pnetid))
    360                         goto out_put;
    361         }
    362 
    363         /* add a new netdev entry to the pnet table if there isn't one */
    364         rc = -ENOMEM;
    365         new_pe = kzalloc(sizeof(*new_pe), GFP_KERNEL);
    366         if (!new_pe)
    367                 goto out_put;
    368         new_pe->type = SMC_PNET_ETH;
    369         memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
    370         strncpy(new_pe->eth_name, eth_name, IFNAMSIZ);
    371         rc = -EEXIST;
    372         new_netdev = true;
    373         write_lock(&pnettable->lock);
    374         list_for_each_entry(tmp_pe, &pnettable->pnetlist, list) {
    375                 if (tmp_pe->type == SMC_PNET_ETH &&
    376                     !strncmp(tmp_pe->eth_name, eth_name, IFNAMSIZ)) {
    377                         new_netdev = false;
    378                         break;
    379                 }
    380         }
    381         if (new_netdev) {
    382                 if (ndev) {
    383                         new_pe->ndev = ndev;
--> 384                         netdev_tracker_alloc(ndev, &new_pe->dev_tracker,
    385                                              GFP_KERNEL);

We can't do a GFP_KERNEL allocation here

    386                 }
    387                 list_add_tail(&new_pe->list, &pnettable->pnetlist);
    388                 write_unlock(&pnettable->lock);

because we're holding this write lock

    389         } else {
    390                 write_unlock(&pnettable->lock);
    391                 kfree(new_pe);
    392                 goto out_put;
    393         }
    394         if (ndev)
    395                 pr_warn_ratelimited("smc: net device %s "
    396                                     "applied user defined pnetid %.16s\n",
    397                                     new_pe->eth_name, new_pe->pnet_name);
    398         return 0;
    399 
    400 out_put:
    401         dev_put(ndev);
    402         return rc;
    403 }

regards,
dan carpenter
