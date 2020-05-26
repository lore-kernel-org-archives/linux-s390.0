Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728746AbgEZJzs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 05:55:48 -0400
Date: Tue, 26 May 2020 11:55:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
Message-ID: <20200526115541.4a11accc.cohuck@redhat.com>
In-Reply-To: <20200513142934.28788-1-farman@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 13 May 2020 16:29:30 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> There was some suggestion earlier about locking the FSM, but I'm not
> seeing any problems with that. Rather, what I'm noticing is that the
> flow between a synchronous START and asynchronous HALT/CLEAR have
> different impacts on the FSM state. Consider:
> 
>     CPU 1                           CPU 2
> 
>     SSCH (set state=CP_PENDING)
>     INTERRUPT (set state=IDLE)
>     CSCH (no change in state)
>                                     SSCH (set state=CP_PENDING)
>     INTERRUPT (set state=IDLE)
>                                     INTERRUPT (set state=IDLE)

A different question (not related to how we want to fix this): How
easily can you trigger this bug? Is this during normal testing with a
bit of I/O stress, or do you have a special test case?
