From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/6] s390: add system call to run tasks with modified
 branch prediction
Date: Wed, 17 Jan 2018 11:05:30 +0100
Message-ID: <61cce127-f8f9-1fec-94c0-de9092c0a356@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-5-git-send-email-schwidefsky@de.ibm.com>
 <5bda76be-0fec-8165-20bf-5cd8e51e955a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5bda76be-0fec-8165-20bf-5cd8e51e955a@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On 17/01/2018 11:03, Florian Weimer wrote:
> On 01/17/2018 10:48 AM, Martin Schwidefsky wrote:
>>          rc = syscall(__NR_s390_modify_bp);
>>          if (rc) {
>>                  perror("s390_modify_bp");
>>                  exit(EXIT_FAILURE);
>>          }
> 
> Isn't this traditionally done through personality or prctl?
> 
> This looks like something other architectures may want as well.

Yes, Intel would want to have a prctl or similar to enable STIBP
(single-thread indirect branch predictor).

Paolo
