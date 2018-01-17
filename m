From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/6] s390: add system call to run tasks with modified
 branch prediction
Date: Wed, 17 Jan 2018 12:50:21 +0100
Message-ID: <299df1a8-f78d-15be-7217-6f201ea849c7@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-5-git-send-email-schwidefsky@de.ibm.com>
 <5bda76be-0fec-8165-20bf-5cd8e51e955a@redhat.com>
 <c80554d9-a7e0-00cf-9f03-b16ce34205c5@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c80554d9-a7e0-00cf-9f03-b16ce34205c5@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Florian Weimer <fweimer@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On 17/01/2018 12:14, Christian Borntraeger wrote:
> 
> 
> On 01/17/2018 11:03 AM, Florian Weimer wrote:
>> On 01/17/2018 10:48 AM, Martin Schwidefsky wrote:
>>>          rc = syscall(__NR_s390_modify_bp);
>>>          if (rc) {
>>>                  perror("s390_modify_bp");
>>>                  exit(EXIT_FAILURE);
>>>          }
>>
>> Isn't this traditionally done through personality or prctl?
> 
> I think we want this per thread (and not per process). So I assume personality
> will not work out. Can a prctl be done per thread?

Yes, prctls can be either per-process (e.g. PR_SET_CHILD_SUBREAPER or
PR_SET_DUMPABLE) or per-thread (e.g. PR_SET_NAME or PR_SET_SECCOMP).

Paolo
