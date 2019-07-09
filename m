Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfGIPaz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jul 2019 11:30:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69FDfsR025327
        for <linux-s390@vger.kernel.org>; Tue, 9 Jul 2019 11:30:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmw9d18ac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 09 Jul 2019 11:30:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 9 Jul 2019 16:30:52 +0100
Date: Tue, 9 Jul 2019 17:30:46 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 0/7] s390: vfio-ap: dynamic configuration support
In-Reply-To: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
References: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190709173046.0a622f3a.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com

On Thu, 13 Jun 2019 15:39:33 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current design for AP pass-through does not support making dynamic
> changes to the AP matrix of a running guest

Sorry guys, I currently don't have the bandwidth to participate in this
discussion. Please proceed without me ;)

Regards,
Halil
