Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388712AbgEZLIL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 07:08:11 -0400
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
References: <20200513142934.28788-1-farman@linux.ibm.com>
 <20200526115541.4a11accc.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <a52368d3-8cec-7b99-1587-25e055228b62@linux.ibm.com>
Date: Tue, 26 May 2020 07:08:07 -0400
MIME-Version: 1.0
In-Reply-To: <20200526115541.4a11accc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 5/26/20 5:55 AM, Cornelia Huck wrote:
> On Wed, 13 May 2020 16:29:30 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> There was some suggestion earlier about locking the FSM, but I'm not
>> seeing any problems with that. Rather, what I'm noticing is that the
>> flow between a synchronous START and asynchronous HALT/CLEAR have
>> different impacts on the FSM state. Consider:
>>
>>     CPU 1                           CPU 2
>>
>>     SSCH (set state=CP_PENDING)
>>     INTERRUPT (set state=IDLE)
>>     CSCH (no change in state)
>>                                     SSCH (set state=CP_PENDING)
>>     INTERRUPT (set state=IDLE)
>>                                     INTERRUPT (set state=IDLE)
> 
> A different question (not related to how we want to fix this): How
> easily can you trigger this bug? Is this during normal testing with a
> bit of I/O stress, or do you have a special test case?
> 

I have hit this with "normal testing with a bit of I/O stress" but it's
been maddeningly slow to repro (invariably when I'm not running with any
detailed traces enabled). So I expedite the process with the channel
path handling code, and this script running on the host:

while True:
    tempChpid = random.choice(chpids)
    tempFunction = random.choice(["-c", "-v"])

    doChzdev(tempFunction, "0", tempChpid)
    doSleep()

    doChzdev(tempFunction, "1", tempChpid)
    doSleep()
