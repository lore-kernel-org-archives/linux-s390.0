Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F832ABF.4060509@suse.cz>
Date: Mon, 09 Apr 2012 20:30:23 +0200
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
Subject: Re: [PATCH 25/69] TTY: con3215, remove tasklet for tty_wakeup
References: <1333367693-3244-1-git-send-email-jslaby@suse.cz> <1333367693-3244-26-git-send-email-jslaby@suse.cz> <20120403054241.GA2700@osiris.boeblingen.de.ibm.com> <4F7AADD7.5070802@suse.cz> <20120409182720.GA12044@kroah.com>
In-Reply-To: <20120409182720.GA12044@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, alan@linux.intel.com, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 04/09/2012 08:27 PM, Greg KH wrote:
> On Tue, Apr 03, 2012 at 09:59:19AM +0200, Jiri Slaby wrote:
>> On 04/03/2012 07:42 AM, Heiko Carstens wrote:
>>> On Mon, Apr 02, 2012 at 01:54:09PM +0200, Jiri Slaby wrote:
>>>> tty_wakeup is safe to be called from all contexts. No need to schedule
>>>> a tasklet for that. Let us call it directly like in other drivers.
>>>>
>>>> And delete the tasklet completely.
>>>
>>> Your patch actually reverts Martin's recent commit 656d912537
>>> "[S390] 3215 deadlock with tty_wakeup".
>>> I'm quite sure the reason for the deadlock still exists.
>>> Unfortunately the commit doesn't contain the call chain that
>>> led to fix.
>>
>> Ok, I would really appreciate the trace.
>>
>> If this is really an issue, we should provide a helper in the TTY layer
>> like tty_schedule_wakeup.
> 
> Jiri, should I not apply this patch?

Yes, please skip it until this is sorted out. And also the other con3215
patches if they don't apply cleanly now.

thanks,
-- 
js
suse labs
