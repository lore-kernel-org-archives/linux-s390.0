Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C864C43381
	for <linux-s390@archiver.kernel.org>; Wed, 24 Feb 2021 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EF364F0C
	for <linux-s390@archiver.kernel.org>; Wed, 24 Feb 2021 16:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhBXQ4q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:56:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235807AbhBXQ4U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Feb 2021 11:56:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OGZCsL146530;
        Wed, 24 Feb 2021 11:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=AmVyFiDlcXmNzyd+x5VKFRhFShv0SsXZhacZ0vpQhTA=;
 b=aQqLJeFq9VbwKsKLv3RwktG/BUNNgD880jb23SXrVZhLNRJnFvT+mA/IIdK8nkPiKR3W
 rd/RUrS4HiRQRD79ms3CA/WeHjZVwLFJYGLwb47QpwIzDatoxW+2CgUW4G0ZVjPvi9Mq
 4qZuHfoKgPXGub1EPKfzsf+/joxeDlUuVkqytzCWLLBQ4KkwpzBHGnbkEGmWzrqYYp+m
 JwMBhrpoL2JoxhriODMWwL/PyUgUYTUeZpzzgL8k+h9YYGLQLUDr3RwMjdDmLL2KTxdM
 DBE60FwSe3wLnxcnq11eo/cSwchFSAPlvIzrKyoF5hvIrFcm7vBk+mF/bMgjdYJsyNti xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wmfwdrdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 11:55:28 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OGZYDE149680;
        Wed, 24 Feb 2021 11:55:27 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wmfwdrcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 11:55:27 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OGq8ll023939;
        Wed, 24 Feb 2021 16:55:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt283qns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 16:55:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OGt9ZZ27525480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 16:55:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3356742054;
        Wed, 24 Feb 2021 16:55:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 912A34204F;
        Wed, 24 Feb 2021 16:55:21 +0000 (GMT)
Received: from thinkpad (unknown [9.171.7.180])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 24 Feb 2021 16:55:21 +0000 (GMT)
Date:   Wed, 24 Feb 2021 17:55:20 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        shu wang <malate_wangshu@hotmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/5] hugetlb: add hugetlb helpers for soft dirty
 support
Message-ID: <20210224175520.76ba0e68@thinkpad>
In-Reply-To: <20210224174608.7c9ca5ed@thinkpad>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
        <20210211000322.159437-2-mike.kravetz@oracle.com>
        <20210217162415.GA6519@xz-x1>
        <20210224174608.7c9ca5ed@thinkpad>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_06:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 24 Feb 2021 17:46:08 +0100
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[...]
> Then we fundamentally changed the way how we deal with that "hugetlb code
> is treating pmds as ptes" issue. Instead of caring about that in all
> huge_pte_xxx primitives, huge_ptep_get() will now return a nicely faked pte
> for s390, i.e. something that looks like a pte would look like, and not the
> real pmd/pud value. With that, hugetlb code can do all its pte handling on
> that fake pte, and the conversion back to a proper pmd/pud is done in
> set_huge_pte().

BTW, in case anybody is wondering, this conversion from and to pmd for s390
will also care about the soft dirty bit, even though it was not really used
before for hugetlb. So Mikes approach to add the default primitives for s390
should work fine.
