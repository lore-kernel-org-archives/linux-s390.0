Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728190AbfJPOak (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 10:30:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9GENxqm082007
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 10:30:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vp46vaa41-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 10:30:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 16 Oct 2019 15:30:37 +0100
Date: Wed, 16 Oct 2019 16:30:21 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] vfio-ccw: A couple trace changes
In-Reply-To: <20191016142040.14132-1-farman@linux.ibm.com>
References: <20191016142040.14132-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20191016163021.1beb591c.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Steffen Maier <maier@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 16 Oct 2019 16:20:36 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Here a couple updates to the vfio-ccw traces in the kernel,
> based on things I've been using locally.  Perhaps they'll
> be useful for future debugging.
> 

Hi! I had a brief look, no full blown review though. You can add an ack
by me for all the patches in this series.

Regards,
Halil
