Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA6DC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0659C60EB7
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 12:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbhIGMW4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:22:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344315AbhIGMWm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Sep 2021 08:22:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187CEc8t072075;
        Tue, 7 Sep 2021 08:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vxQ/lViwCp7JVm6b0LeU8qRx+E3t5GMVDImyOrpR9rQ=;
 b=ixNa7tN0mDYkql1x5Ty1elg3Yc7ohP3qKNgrX0AH1eO3vu9ZZYweuMlLTFKpEHi2KtgM
 24yXnbDLgfl9xW858lVjKTP1x4451AEElmHIM96Q9S5cbi/X6GEFedDvprDabEJuGMSn
 /VDEslLP+2V9FY21hsbpUGYKvhLPxHuSErDAOyPLCMUFkmRTubmRRWKlz38WaSSed48W
 cxrpUTNo+z3s2jR3MUXzO8vaiwNwyGx0D3RjP9YhwyVrf5aiJeTIUesBnfObkTHJWouD
 bwv5ZC3Qy8wCPjCGUc+4zOLim+kyuj7x00bXD1NPaVuQp7PVDOm1WPowAGtTjAi09017 YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ax78m96me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 08:21:24 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 187CEuCF072919;
        Tue, 7 Sep 2021 08:21:24 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ax78m96kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 08:21:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 187CC3DU028211;
        Tue, 7 Sep 2021 12:21:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3av0e9eyhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 12:21:22 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 187CH60t60752128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 12:17:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7255A4054;
        Tue,  7 Sep 2021 12:21:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49E49A405C;
        Tue,  7 Sep 2021 12:21:18 +0000 (GMT)
Received: from sig-9-145-36-222.uk.ibm.com (unknown [9.145.36.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Sep 2021 12:21:18 +0000 (GMT)
Message-ID: <0c9326c943c0e6aa572cc132ee2deb952bf41c7f.camel@linux.ibm.com>
Subject: Re: [PATCH 0/5] s390/pci: automatic error recovery
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linas Vepstas <linasvepstas@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 07 Sep 2021 14:21:17 +0200
In-Reply-To: <e739c2919f97e277849a1bc1324a20df6a7d59eb.camel@linux.ibm.com>
References: <20210906094927.524106-1-schnelle@linux.ibm.com>
         <CAOSf1CFyuf9FaeSNparj+7W0mKTPvtcM8vxjHDSFsNDC6k_7xQ@mail.gmail.com>
         <e739c2919f97e277849a1bc1324a20df6a7d59eb.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SkUon7ztrKqjkeIh7btB_xV5c0wMpkDT
X-Proofpoint-GUID: qZD9o8qgwlzYyZe-rDOYlYcLItkcgiQA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_04:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 mlxlogscore=904 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070080
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2021-09-07 at 10:45 +0200, Niklas Schnelle wrote:
> On Tue, 2021-09-07 at 12:04 +1000, Oliver O'Halloran wrote:
> > On Mon, Sep 6, 2021 at 7:49 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > Patch 3 I already sent separately resulting in the discussion below but without
> > > a final conclusion.
> > > 
> > > https://lore.kernel.org/lkml/20210720150145.640727-1-schnelle@linux.ibm.com/
> > > 
> > > I believe even though there were some doubts about the use of
> > > pci_dev_is_added() by arch code the existing uses as well as the use in the
> > > final patch of this series warrant this export.
> > 
> > The use of pci_dev_is_added() in arch/powerpc was because in the past
> > pci_bus_add_device() could be called before pci_device_add(). That was
> > fixed a while ago so It should be safe to remove those calls now.
> 
> Hmm, ok that confirms Bjorns suspicion and explains how it came to be.
> I can certainly sent a patch for that. This would then leave only the
> existing use in s390 which I added because of a dead lock prevention
> and explained here:
> https://lore.kernel.org/lkml/87d15d5eead35c9eaa667958d057cf4a81a8bf13.camel@linux.ibm.com/
> 
> Plus the need to use it in the recovery code of this series. I think in
> the EEH code the need for a similar check is alleviated by the checks
> in the beginning of
> arch/powerpc/kernel/eeh_driver.c:eeh_handle_normal_event() especially
> eeh_slot_presence_check() which checks presence via the hotplug slot.
> I guess we could use our own state tracking in a similar way but felt
> like pci_dev_is_added() is the more logical choice.

Looking into this again, I think we actually can't easily track this
state ourselves outside struct pci_dev. The reason for this is that
when e.g. arch/s390/pci/pci_sysfs.c:recover_store() removes the struct
pci_dev and scans it again the new struct pci_dev re-uses the same
struct zpci_dev because from a platform point of view the PCI device
was never removed but only disabled and re-enabled. Thus we can only
distinguish the stale struct pci_dev by looking at things stored in
struct pci_dev itself.

That said, I think for the recovery case we might be able to drop the
pci_dev_is_added() and rely on pdev->driver != NULL which we check
anyway and that should catch any PCI device that was already removed.

