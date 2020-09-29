Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728401AbgI2QTY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Sep 2020 12:19:24 -0400
Date: Tue, 29 Sep 2020 18:19:14 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 06/16] s390/vfio-ap: introduce shadow APCB
Message-ID: <20200929181914.64da90fd.pasic@linux.ibm.com>
In-Reply-To: <5cca8962-4f08-9c92-032c-9b6d1b514e33@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-7-akrowiak@linux.ibm.com>
        <20200926033808.07e9d04f.pasic@linux.ibm.com>
        <5cca8962-4f08-9c92-032c-9b6d1b514e33@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 29 Sep 2020 12:04:25 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >
> > I suppose this is probably about no guest unolies no resources passed
> > through at the moment. If that is the case maybe we can document it
> > below.  
> 
> I'm not quite sure what you are saying here or what I should be
> documenting below.

No wonder, took me like 10 seconds to figure it out myself. The solution
is s/unolies/implies. I was one off to the left when typing 'imp'. 
