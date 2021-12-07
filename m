Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D7C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  7 Dec 2021 17:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhLGRoZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:44:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6896 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbhLGRoZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Dec 2021 12:44:25 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7GptKk008525
        for <linux-s390@vger.kernel.org>; Tue, 7 Dec 2021 17:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sapi+1WJMj4XmAro8Lx+FM3mApZBsNe84ybL6n0u1XQ=;
 b=c0qkudIa/HJvmPJqc24ybPCSgsBTKhgd9aip1r9M3CW1IkZaJpAGuCt/UZB83lGaqUvd
 /LnAoR+prYi0BksPo8NSaPDJUU77A2o2JMOZjW7fowk8jbKJEQJ0tPvfT2viqEB2kUYn
 5RcyQoXtuKx82Lvo+mK7QWkbMCHz/xLWkWnw2IxVG5IhR13sI1br8/cVAtzqAZD8cgWY
 8RBeJvXJVZuJQSZ8vxJmMnfOPmbw8OFbzuNuny+WysNzgVmvSsvXbf4N19HWi9dGf4sb
 Ld/JxPKr+X/xPJb4LzTkkqUrgG1UV5SqUcNXt7+Mt+s8TaTmBpWWbVFdfCvN9V32xj3D Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctbgt0ysb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Dec 2021 17:40:54 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7HG2xu030052
        for <linux-s390@vger.kernel.org>; Tue, 7 Dec 2021 17:40:53 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctbgt0yrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 17:40:53 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7HVrM6012628;
        Tue, 7 Dec 2021 17:40:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3cqyy9fq1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 17:40:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7HentG18809186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 17:40:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13D1811C052;
        Tue,  7 Dec 2021 17:40:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEA0C11C050;
        Tue,  7 Dec 2021 17:40:48 +0000 (GMT)
Received: from osiris (unknown [9.145.144.163])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Dec 2021 17:40:48 +0000 (GMT)
Date:   Tue, 7 Dec 2021 18:40:47 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     linux-s390@vger.kernel.org, egorenar@linux.ibm.com, ltao@redhat.com
Subject: Re: [PATCH v2 1/2] s390/kexec_file: print some more error messages
Message-ID: <Ya+cn+1tNhCPtXeQ@osiris>
References: <20211207125749.6998-1-prudo@redhat.com>
 <20211207125749.6998-2-prudo@redhat.com>
 <Ya9988i7o788He/z@osiris>
 <20211207181855.521b7d94@rhtmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207181855.521b7d94@rhtmp>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pAS62S2v_56CZC6pp0hTItT95Uu4HGFx
X-Proofpoint-ORIG-GUID: 51Wtq3oRsLPFIEn04Vop5H-b51LBKKum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=880 bulkscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070109
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> > > -		if (sym->st_shndx == SHN_COMMON)
> > > +		if (sym->st_shndx == SHN_COMMON) {
> > > +			pr_err("symbol in common section\n");
> > >  			return -ENOEXEC;
> > > +		}
> > >  
> > >  		if (sym->st_shndx >= pi->ehdr->e_shnum &&
> > > -		    sym->st_shndx != SHN_ABS)
> > > +		    sym->st_shndx != SHN_ABS) {
> > > +			pr_err("Invalid section %d for symbol\n",
> > > +			       sym->st_shndx);
> > >  			return -ENOEXEC;  
> > 
> > So, if you add the additional error messages here, then I'd really
> > like to see also the name of the symbol which is causing
> > problems. Just like it is done on x86.
> > Sorry for nitpicking :)
> 
> I actually dropped the name on purpose. At least for my work flow
> knowing which check failed is more important as that already allows
> me to search for, e.g. all undefined symbols as each of them can cause
> trouble. Which symbol exactly triggered the check isn't that important.
> In addition, the code to get a symbol name is rather ugly. At least
> when you compare it to its usefulness.
> 
> But when you insist...

Yes, please.

> P.S. To avoid an other round for that patch. Do you also want the two
>      pr_debugs?

No, I don't think they are needed.

Thank you!
