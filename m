Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B95C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  9 Dec 2021 11:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhLILTk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Dec 2021 06:19:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236469AbhLILTk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Dec 2021 06:19:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B99wbjw012697
        for <linux-s390@vger.kernel.org>; Thu, 9 Dec 2021 11:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7U6q848gWzDgyibAnUVFRqgT3L4UugWabdVD/3E4JZU=;
 b=VWFraN0qOC/bD5bSPGSt/08Ha4U7k3DSAx1D+uprI1qO3rNya6o5pg2TNW7+r43AQ9nc
 ETYUopHtzU9FvgiMn+Zrbty13fJaE26Nl1GGdHyvahb5LaaQ32rBm7GyJUrNsvsqHwtw
 k5ycP+Q5GtSjjyIqJK1k2WKXmsRAQgztVd5UdtqgowGaYDZob3BwQ0zm3Ftym2PeDfQ2
 NcAm31JlL3skiBtxmTxYti2QTqSp/iI4Vqmjitfg92Ou3t4lAM+suylagID+x0J0+tHu
 KE3mOC5Cm55nOQwpAapcpGecLX8hxh3rFiFDVDZCjpTatM4zH+6AnF3cKNUXaf/veMXq Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cufmy9jj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Dec 2021 11:16:06 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B9AtT4m026250
        for <linux-s390@vger.kernel.org>; Thu, 9 Dec 2021 11:16:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cufmy9jh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 11:16:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B9B7xoe032333;
        Thu, 9 Dec 2021 11:16:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3cqyyagfy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 11:16:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B9BG0pj28836218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 11:16:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9ACEA4053;
        Thu,  9 Dec 2021 11:16:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D795A404D;
        Thu,  9 Dec 2021 11:16:00 +0000 (GMT)
Received: from osiris (unknown [9.145.88.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Dec 2021 11:16:00 +0000 (GMT)
Date:   Thu, 9 Dec 2021 12:15:59 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>, ltao@redhat.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/kexec: handle R_390_PLT32DBL rela in
 arch_kexec_apply_relocations_add()
Message-ID: <YbHlb2YTjVzDqoTe@osiris>
References: <20211209073817.82196-1-egorenar@linux.ibm.com>
 <20211209120142.60642497@rhtmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209120142.60642497@rhtmp>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G1ATxrBy5dQgO5YLgdqAjytTyXJmphad
X-Proofpoint-GUID: F3m_QsGepIVq0Izs4zbMWYhllMJudjhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_04,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090059
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Dec 09, 2021 at 12:01:42PM +0100, Philipp Rudo wrote:
> On Thu,  9 Dec 2021 08:38:17 +0100
> Alexander Egorenkov <egorenar@linux.ibm.com> wrote:
> 
> > Starting with gcc 11.3, the C compiler will generate PLT-relative function
> > calls even if they are local and do not require it. Later on during linking,
> > the linker will replace all PLT-relative calls to local functions with
> > PC-relative ones. Unfortunately, the purgatory code of kexec/kdump is
> > not being linked as a regular executable or shared library would have been,
> > and therefore, all PLT-relative addresses remain in the generated purgatory
> > object code unresolved. This leads to the situation where the purgatory
> > code is being executed during kdump with all PLT-relative addresses
> > unresolved. And this results in endless loops within the purgatory code.
> > 
> > Furthermore, the clang C compiler has always behaved like described above
> > and this commit should fix kdump for kernels built with the latter.
> > 
> > Because the purgatory code is no regular executable or shared library,
> > contains only calls to local functions and has no PLT, all R_390_PLT32DBL
> > relocation entries can be resolved just like a R_390_PC32DBL one.
...
> > Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > Reported-by: Tao Liu <ltao@redhat.com>
> > Suggested-by: Philipp Rudo <prudo@redhat.com>
> 
> Thanks!
> 
> Reviewed-by: Philipp Rudo <prudo@redhat.com>

Applied, thanks!
