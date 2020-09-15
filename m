Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbgIOKbM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Sep 2020 06:31:12 -0400
Date: Tue, 15 Sep 2020 12:31:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200915123101.0861b091.cohuck@redhat.com>
In-Reply-To: <923020f2-e722-a6ba-fcb4-08dd8228fc00@linux.vnet.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
        <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
        <20200423182001.40345df8.cohuck@redhat.com>
        <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
        <20200430124316.023a82b0.cohuck@redhat.com>
        <20200629135631.10db3c32.cohuck@redhat.com>
        <20200701112313.62a22156.cohuck@redhat.com>
        <20200914134642.5e2e2c0e.cohuck@redhat.com>
        <923020f2-e722-a6ba-fcb4-08dd8228fc00@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

On Tue, 15 Sep 2020 12:25:32 +0200
Vineeth Vijayan <vneethv@linux.vnet.ibm.com> wrote:

> Hi Conny,
> Thank you for the ping. This is pending for a long time and we just resumed
> looking at this approach. Me and Peter had a short discussion on this and we
> are trying to do some cleaning as well on the CIO layer while working 
> with the
> new approach.
> 
> There are few uncertainties with the new approach, which we would like 
> to clarify
> and i am trying to test it.For example, the impact on the way 
> cio-console driver works.

Yes, the console might be fun.

> So, as discussed with Peter, let me make a smaller draft which will 
> consolidate
> your approach and the "cleaning" part that we would like to do.
> 
> As mentioned, i will resume working on this and get back to you with 
> myfindings.

Thanks for the update; I'll do my best to find some time to look at any
patches you send.
