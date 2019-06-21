Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbfFUQTr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 12:19:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LGCW41144009
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 12:19:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8yb41gtj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 12:19:45 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sebott@linux.ibm.com>;
        Fri, 21 Jun 2019 17:19:41 +0100
Date: Fri, 21 Jun 2019 18:19:36 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
In-Reply-To: <20190613110815.17251-1-cohuck@redhat.com>
References: <20190613110815.17251-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1906211817010.2388@schleppi>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Cornelia Huck wrote:
> Sometimes, we want to control which of the matching drivers
> binds to a subchannel device (e.g. for subchannels we want to
> handle via vfio-ccw).
> 
> For pci devices, a mechanism to do so has been introduced in
> 782a985d7af2 ("PCI: Introduce new device binding path using
> pci_dev.driver_override"). It makes sense to introduce the
> driver_override attribute for subchannel devices as well, so
> that we can easily extend the 'driverctl' tool (which makes
> use of the driver_override attribute for pci).
> 
> Note that unlike pci we still require a driver override to
> match the subchannel type; matching more than one subchannel
> type is probably not useful anyway.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>

Should I take that via our git tree or do you have other patches depending 
on this one?
