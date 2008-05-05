From: Avi Kivity <avi@qumranet.com>
Subject: Re: s390 kvm_virtio.c build error
Date: Mon, 05 May 2008 16:00:52 +0300
Message-ID: <481F0504.3010503@qumranet.com>
References: <20080503174716.GM5838@cs181133002.pp.htv.fi> <20080504192537.GA5499@osiris.boeblingen.de.ibm.com> <200805051429.47446.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759048AbYEENB3@vger.kernel.org>
In-Reply-To: <200805051429.47446.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Adrian Bunk <bunk@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Christian Borntraeger wrote:
>> Hmm... this should help:
>>
>> ---
>>  drivers/s390/kvm/kvm_virtio.c |   40 
>>     
> +++++++++++++++++++++++-----------------
>   
>>  1 file changed, 23 insertions(+), 17 deletions(-)
>>     
>
> Thanks Heiko.
> I did a short test and it seems to work.
>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>
> This looks almost identical to Rusty's patch. Who is going to send this (or 
> Rustys) patch to Linus?
>   

I can, but tell me which one.  Also, the patch (Heiko's) needs a 
changelog entry and a signoff.

-- 
error compiling committee.c: too many arguments to function
