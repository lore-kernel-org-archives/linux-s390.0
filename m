Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9341C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A206103E
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 08:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbhIGIrF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Sep 2021 04:47:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243034AbhIGIrD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Sep 2021 04:47:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1878XPIs018726;
        Tue, 7 Sep 2021 04:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=momNzXh5abBV6MIvBH8RtUWxbLoQjtaBLuy63qlGL9s=;
 b=Eb1v2xyyKzOjlMcelzMPa5U3vvYevre28Gcsx7MqfMswZcL8dPNViow6Oe5gr/W/JbjW
 rHsobmLU82uHnaY0ILgXsVJlzEMDite2K6C43ZOMynT5VmZMPyJf0sADYY4N9qWnGinv
 QlIFm1PHVgqkJhSo0J9ZiWkpkc+gPW7uN0xLQM2+3O6CDVhIaVxS4VHKg0ozbI+Oibx2
 4sctYIB7YboifiVmIaC7naQkRoROBqpJo6hVEqxIV+TN4p4QGMKsAknleEgWhf+B36Yb
 8ISZiMk+m/A6qXqNMNugOxdnZ9WDrpfQKGRFxK27ZofJa/S3vwdsGrgQ3yN55lu4nLcJ nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ax4mh0eej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 04:45:49 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1878hWYl057690;
        Tue, 7 Sep 2021 04:45:49 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ax4mh0edq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 04:45:49 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1878fuKX019931;
        Tue, 7 Sep 2021 08:45:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3av0e9kecf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 08:45:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1878fTJ056885724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 08:41:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 569C6A405F;
        Tue,  7 Sep 2021 08:45:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F2EA406A;
        Tue,  7 Sep 2021 08:45:41 +0000 (GMT)
Received: from sig-9-145-36-222.uk.ibm.com (unknown [9.145.36.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Sep 2021 08:45:41 +0000 (GMT)
Message-ID: <e739c2919f97e277849a1bc1324a20df6a7d59eb.camel@linux.ibm.com>
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
Date:   Tue, 07 Sep 2021 10:45:41 +0200
In-Reply-To: <CAOSf1CFyuf9FaeSNparj+7W0mKTPvtcM8vxjHDSFsNDC6k_7xQ@mail.gmail.com>
References: <20210906094927.524106-1-schnelle@linux.ibm.com>
         <CAOSf1CFyuf9FaeSNparj+7W0mKTPvtcM8vxjHDSFsNDC6k_7xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 74Uy7VeVZ7qjlhBZx_vusWWa23hofZoL
X-Proofpoint-ORIG-GUID: Ncih92Xabldn9mYZhjJewLgcjIWiqNsn
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_02:2021-09-03,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070056
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2021-09-07 at 12:04 +1000, Oliver O'Halloran wrote:
> On Mon, Sep 6, 2021 at 7:49 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > Patch 3 I already sent separately resulting in the discussion below but without
> > a final conclusion.
> > 
> > https://lore.kernel.org/lkml/20210720150145.640727-1-schnelle@linux.ibm.com/
> > 
> > I believe even though there were some doubts about the use of
> > pci_dev_is_added() by arch code the existing uses as well as the use in the
> > final patch of this series warrant this export.
> 
> The use of pci_dev_is_added() in arch/powerpc was because in the past
> pci_bus_add_device() could be called before pci_device_add(). That was
> fixed a while ago so It should be safe to remove those calls now.

Hmm, ok that confirms Bjorns suspicion and explains how it came to be.
I can certainly sent a patch for that. This would then leave only the
existing use in s390 which I added because of a dead lock prevention
and explained here:
https://lore.kernel.org/lkml/87d15d5eead35c9eaa667958d057cf4a81a8bf13.camel@linux.ibm.com/

Plus the need to use it in the recovery code of this series. I think in
the EEH code the need for a similar check is alleviated by the checks
in the beginning of
arch/powerpc/kernel/eeh_driver.c:eeh_handle_normal_event() especially
eeh_slot_presence_check() which checks presence via the hotplug slot.
I guess we could use our own state tracking in a similar way but felt
like pci_dev_is_added() is the more logical choice.

> 
> > Patch 4 "PCI: Export pci_dev_lock()" is basically an extension to commit
> > e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()") which
> > already exported pci_dev_trylock(). In the final patch we make use of
> > pci_dev_lock() to wait for any other exclusive uses of the pdev to be finished
> > before starting recovery.
> 
> Hmm, I noticed the EEH
> (arch/powerpc/kernel/eeh_driver.c:eeh_pe_report_edev())  and the
> generic PCIe error recovery code (see
> drivers/pci/pcie/err.c:report_error_detected()) only call
> device_lock() before entering the driver's error handling callbacks. I
> wonder if they should be using pci_dev_lock() instead. The only real
> difference is that pci_dev_lock() will also block user space from
> accessing the device's config space while error recovery is in
> progress which seems sensible enough.

I agree that sounds reasonable.

