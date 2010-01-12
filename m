From: Avi Kivity <avi@redhat.com>
Subject: Re: KVM: fix S390/IA-64 build failures introduced by memslot changes
Date: Tue, 12 Jan 2010 14:08:18 +0200
Message-ID: <4B4C6632.9090109@redhat.com>
References: <20100111194431.c103db9b.sfr@canb.auug.org.au> <4B4AFA45.8000004@in.ibm.com> <4B4AFE26.5080503@redhat.com> <20100111172309.GA13797@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100111172309.GA13797@amt.cnet>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/11/2010 07:23 PM, Marcelo Tosatti wrote:
> Fix build failures introduced by memslot changes.
>    

Thanks, applied, and folded back into relevant kvm-updates/2.6.34 commits.

-- 
error compiling committee.c: too many arguments to function
