Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B22BC433ED
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 12:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160AF6108B
	for <linux-s390@archiver.kernel.org>; Tue,  6 Apr 2021 12:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbhDFMD3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:03:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235453AbhDFMD3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 08:03:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136Ba4FE079777;
        Tue, 6 Apr 2021 08:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=+uYQ7q44KFHwjVCmXGtKPxxr2jwoaS/fH9Dduu84SvE=;
 b=fxXz520qrjy5Y3WVsIXmlGsJKk3g2VXe9R9F3UYQN/769fsKXXekQVbPPxI8Zdm27ZO6
 MSwxgYbR/3nMvm2/b9gRTHlvYx5Tgf2/rTfe1mDwgB4qoxr802zK/1H6Ig/srVxEnYKg
 JDIPqsZpCP+3y6ZOdHveK/9F/XxaZ+A3jHb0oBYfYPZs0voaTFJpjykUq/a/t9GnZ8X+
 Hg3MxdLGCGtclqAgYTN0dARUIldEOyn3NCN+a7x7K+zZ9tEnS9SpMpt53sOCAet7DtOX
 vafIJYoaa3GsYW0qWDm5BK+gUDRqTIj+Qbwj7D/g95jAuu4Tvp3SQ+S9JL1NWAiorhd5 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37q6058n55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 08:02:59 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136Ba2RI079604;
        Tue, 6 Apr 2021 08:02:58 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37q6058n42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 08:02:58 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136C2udl023436;
        Tue, 6 Apr 2021 12:02:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 37q2q5j47n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 12:02:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136C2rV250528550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 12:02:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F2A7A4064;
        Tue,  6 Apr 2021 12:02:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFF0BA4060;
        Tue,  6 Apr 2021 12:02:52 +0000 (GMT)
Received: from thinkpad (unknown [9.171.37.150])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  6 Apr 2021 12:02:52 +0000 (GMT)
Date:   Tue, 6 Apr 2021 14:02:51 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
Message-ID: <20210406140251.2779c400@thinkpad>
In-Reply-To: <CAHbLzkquYxq_eXoVhUCib9qu_aMS9U2XXjb5pop9JtJ8uco_vg@mail.gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
        <20210330164200.01a4b78f@thinkpad>
        <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com>
        <20210331134727.47bc1e6d@thinkpad>
        <CAHbLzkquYxq_eXoVhUCib9qu_aMS9U2XXjb5pop9JtJ8uco_vg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q_zihSF78QLKrq41D9xh6d-N3kDj0peG
X-Proofpoint-GUID: vq66MAHLKvi_HZbyGR0D4zY8xfe448cU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_02:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=863
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060080
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 1 Apr 2021 13:10:49 -0700
Yang Shi <shy828301@gmail.com> wrote:

[...]
> > >
> > > Yes, it could be. The old behavior of migration was to return -ENOMEM
> > > if THP migration is not supported then split THP. That behavior was
> > > not very friendly to some usecases, for example, memory policy and
> > > migration lieu of reclaim (the upcoming). But I don't mean we restore
> > > the old behavior. We could split THP if it returns -ENOSYS and the
> > > page is THP.
> >
> > OK, as long as we don't get any broken PMD migration entries established
> > for s390, some extra THP splitting would be acceptable I guess.
> 
> There will be no migration PMD installed. The current behavior is a
> no-op if THP migration is not supported.

Ok, just for completeness, since Mel also replied that the split
was not done on other architectures "because the loss from splitting
exceeded the gain of improved locality":

I did not mean to request extra splitting functionality for s390,
simply skipping / ignoring large PMDs would also be fine for s390,
no need to add extra complexity.
