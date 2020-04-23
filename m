Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729176AbgDWP4P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 11:56:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NFbfTR043763
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 11:56:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc30jbr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 11:56:14 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03NFbhcY043866
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 11:56:13 -0400
Date: Thu, 23 Apr 2020 17:55:59 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200423175559.309cc924.pasic@linux.ibm.com>
In-Reply-To: <20200417143811.7e6ecb2c.cohuck@redhat.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

On Fri, 17 Apr 2020 14:38:11 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Friendly ping.
> 

Sorry for the late answer. I prefer to let Vineeth give us his opinion
first. I did invest some 30 minutes in understanding the problem, but
I'm not sure I understood it properly. According to my current
understanding, the current state of affairs is a mess, and the proposed
change wouldn't make the situation substantially cleaner, but it would
help with the problem at hand.

Conny, do you have more background information on uevent suppression
(is there some sort of a generic contract between kernel and userspace
for uevent suppression)?

From a quick grep it seems to me that most of the uses are about being
nice to userspace in a sense, that we want to make sure that when
event is received by userspace it can do it's thing, and does not have
to wait until the kernel has finished with the stuff that needs to be
done to reach a state of affairs that can be considered normal.

Regards,
Halil



> On Fri, 3 Apr 2020 12:40:32 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Hi,
> > 
> > this is kind-of-a-followup to the uevent patches I sent in
> > <20200327124503.9794-1-cohuck@redhat.com> last Friday.
> > 
> > Currently, the common I/O layer will suppress uevents for subchannels
> > that are being registered, delegating generating a delayed ADD uevent
> > to the driver that actually binds to it and only generating the uevent
> > itself if no driver gets bound. The initial version of that delaying
> > was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
> > subchannels"); from what I remember, we were seeing quite bad storms of
> > uevents on LPARs that had a lot of I/O subchannels with no device
> > accessible through them.
[..]
> > Thoughts?
> > 
> 
