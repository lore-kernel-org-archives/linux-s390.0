Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD3C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5929D61107
	for <linux-s390@archiver.kernel.org>; Wed, 10 Nov 2021 15:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhKJPVb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:21:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231743AbhKJPVa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Nov 2021 10:21:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAEtRx6028274;
        Wed, 10 Nov 2021 15:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=HW7Kl1MQFM0BkBddD88/pIpAwZhXGdUz0xBlIIt9TFc=;
 b=NDXijefgn7RIbJscFc9UTa0TeCqQylevHXveFN7Ub3cFp/DLUkj3mhSslxoLmnHYJo77
 o+WiERDCTfUS8jluYKbyDdfc6QMuwBKOpDaD+d3mYgyLGpSh8LuNSxj2+NWtcDPLUDZm
 S1X+cGapv/7Ru8Cav6+lOHOH6s77PCJ37owjWj/OqrpXNXC5qBhG4Wd8CaPeP1Jm2rey
 KhdRoMiKBKfFL8y6cjE2Qrm/VPQdXVWxqxGMTY8s52qjrZPqTip06POM2sBKmo4Ydrpt
 ZeSHEy5AVReXmZ4pvPhI29CZA7d2do8TAItxKGsRrQgP8+0q2phUWBzjQc+X20QpwSGK FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8ecc40wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:18:33 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AADRdxU002139;
        Wed, 10 Nov 2021 15:18:33 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8ecc40w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:18:33 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AAFDCYa006831;
        Wed, 10 Nov 2021 15:18:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3c5hba9rbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:18:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AAFBmIO26804522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 15:11:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0169E11C058;
        Wed, 10 Nov 2021 15:18:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC23511C071;
        Wed, 10 Nov 2021 15:18:27 +0000 (GMT)
Received: from osiris (unknown [9.145.55.149])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Nov 2021 15:18:27 +0000 (GMT)
Date:   Wed, 10 Nov 2021 16:18:26 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        dyoung@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH] s390/kexec: fix memory leak of ipl report buffer
Message-ID: <YYviwi3PVD11xcCs@osiris>
References: <20211029092635.14804-1-bhe@redhat.com>
 <20211029183132.20839ad0@rhtmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029183132.20839ad0@rhtmp>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7IfjqiT3O8J9M4ZLwYOo6ydICH44Qp25
X-Proofpoint-ORIG-GUID: xeJVl4jtQeuUMYxFAbg6s0aftZgQFUI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=981 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111100079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 29, 2021 at 06:31:32PM +0200, Philipp Rudo wrote:
> Hi Baoquan,
> 
> On Fri, 29 Oct 2021 17:26:35 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > A memory leak is reported by kmemleak scanning:
...
> > The ipl report buffer is allocated via vmalloc, while has no chance to free
> > if the kexe loading is unloaded. This will cause obvious memory leak
> > when kexec/kdump kernel is reloaded, manually, or triggered, e.g by
> > memory hotplug.
> > 
> > Here, add struct kimage_arch to s390 to pass out the ipl report buffer
> > address, and introduce arch dependent function
> > arch_kimage_file_post_load_cleanup() to free it when unloaded.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> other than a missing
> 
> Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to
> next kernel")
> 
> the patch looks good to me.
> 
> Reviewed-by: Philipp Rudo <prudo@redhat.com>
...
> >  	buf.buffer = ipl_report_finish(data->report);
> >  	buf.bufsz = data->report->size;
> >  	buf.memsz = buf.bufsz;
> > +	image->arch.ipl_buf = buf.buffer;

This seems (still) to be incorrect: ipl_report_finish() may return
-ENOMEN, but there is no error checking anywhere, as far as I can
tell, which would make this:

> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	kvfree(image->arch.ipl_buf);
> > +	image->arch.ipl_buf = NULL;
> > +
> > +	return kexec_image_post_load_cleanup_default(image);
> > +}

most likely not do what we want. That is: if this code is reached at
all in such a case. I'll check and might add a patch before this to
fix this also.
