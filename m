Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2477FECAAA1
	for <linux-s390@archiver.kernel.org>; Tue, 30 Aug 2022 19:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiH3TNR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Aug 2022 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiH3TNP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Aug 2022 15:13:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEE075FDC
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 12:13:15 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIh3NX026119
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 19:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NtoOe6WKbHprDcsAef3iBLjVmo+OPCdWbZTTIhV+VEA=;
 b=N9L1F5wuvuI21ifIDaLlla0e6SbNUsrvnjuN8xQLv7kr89muhKA0WQX82IzrvdQjI2UL
 k2IuNF4w4KFUywLvASxcbR835H7VvJJgm1U0pj5p/Yu7ZeTPPdV34qC8sBtXyVRPnrkt
 qJeErqbsrdHIXbjoJhGSBnybIS4+Dm3F1skg+9Ow773fxd3e09VZwJJVF73gtPMjdkGm
 H3lATAdSgCXH14yxo4XAQmsLL6T9bOy2u9bXLurzeiClklNlEdUluJ/dYYZ0x7VMKVsa
 X4CGrENu6LnQJOOGgC3tZmud+tp3K0V4AlqCVxHv0PFxDrBNT/u94m8jrS7fXbSRS92u 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9r2urs3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 19:13:14 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27UIhUZ6028769
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 19:13:14 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9r2urs34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 19:13:14 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27UIo7kK026760;
        Tue, 30 Aug 2022 19:13:13 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3j7aw9k353-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 19:13:13 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27UJDCSC63242586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:13:12 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6796DC6057;
        Tue, 30 Aug 2022 19:13:11 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E4CC6055;
        Tue, 30 Aug 2022 19:13:10 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.160.166.125])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 19:13:10 +0000 (GMT)
Message-ID: <9fe918c32c769e47dd38e1b48f5eb35f1bd31976.camel@linux.ibm.com>
Subject: Re: buffer overflow in
 vfio_ccw_async_region_write/vfio_ccw_async_region_read
From:   Eric Farman <farman@linux.ibm.com>
To:     sohu0106 <sohu0106@126.com>, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Date:   Tue, 30 Aug 2022 15:13:10 -0400
In-Reply-To: <255c7ef5.6bf9.181f1d3637e.Coremail.sohu0106@126.com>
References: <255c7ef5.6bf9.181f1d3637e.Coremail.sohu0106@126.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lZv3h3tY4rIZBhVnEatElWZcpQeEv6VH
X-Proofpoint-ORIG-GUID: Y6OroSOvQGDBrSSz0OaFR2Hyv-NmI23M
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

(Apologies for the delay; I was on holiday when this came in and it was
lost in the noise.)

On Tue, 2022-07-12 at 17:52 +0800, sohu0106 wrote:
> >=20
> > In the vfio_ccw_async_region_write/vfio_ccw_async_region_read >
> > function of drivers/s390/cio/vfio_ccw_async.c, parameter "size_t >
> > count" is pass by userland, if "count" is very large, it will
> > bypass > "if (pos + count > sizeof(*region))".(such as
> > count=3D0xffffffff). Then > it will lead to buffer overflow in
> > "copy_from_user((void *)region + > pos, buf, count)".=C2=A0

There are some mechanical problems with this patch. It needs a Signed-
off-by tag, and is not applicable in its current form. All easy to
resolve, and documented in:=C2=A0

Documentation/process/submitting-patches.rst

Having said that, I'm not sure that the problem exists as you describe.
In my tests, submitting a very large count (0xffffffff, per your
example) gets capped to MAX_RW_COUNT [1] before it gets here. If you
have a mechanism that shows otherwise, I'd like to see it so that I can
revisit my own test scenarios. Seeing it fail would imply that the
async region is not the only one affected, and a new version of this
patch would need to also address the io and schib regions in vfio-ccw.

Thanks,
Eric

[1]
https://lore.kernel.org/all/CAADWXX9rrESSEGmA4C9F85E9jo7H-pv+CUtyAU_kyB=3DD=
fcHRpA@mail.gmail.com/


> >=20
> >=20
> >=20
> >=20
> > diff --git a/vfio_ccw_async.c_org b/vfio_ccw_async.c
> > index 7a838e3..33339ad 100644
> > --- a/vfio_ccw_async.c_org
> > +++ b/vfio_ccw_async.c
> > @@ -21,7 +21,7 @@ static ssize_t vfio_ccw_async_region_read(struct
> > > vfio_ccw_private *private,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ccw_cmd_region *region;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;
> >=20
> >=20
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pos + count > sizeof(*region))
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pos + count > sizeof(*region) && pos + =
count > pos)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> >=20
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&private->io_mutex);
> > @@ -43,7 +43,7 @@ static ssize_t vfio_ccw_async_region_write(struct
> > > vfio_ccw_private *private,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ccw_cmd_region *region;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;
> >=20
> >=20
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pos + count > sizeof(*region))
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pos + count > sizeof(*region) && pos + =
count > pos)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> >=20
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mutex_trylock(&private->io_mutex))
> >=20

