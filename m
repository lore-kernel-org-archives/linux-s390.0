From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Let user space control the cpu states
Date: Mon, 21 Jul 2014 11:46:18 +0200
Message-ID: <53CCE16A.9020301@redhat.com>
References: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com> <53C933EB.9020707@redhat.com> <53CCC5A3.4000107@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53CCC5A3.4000107@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 21/07/2014 09:47, Christian Borntraeger ha scritto:
> So having such a state wont buy us much. It would be even wrong, because
> we want our MP_STATE defines to be a 1:1 match of the states that are defined
> in the architecture as proper CPU states. Some of the SIGP calls will return the
> state of the target CPU and that depends on the CPU state as defined in the
> architecture. The wait bit does not have an influence on the return value.

Thanks for the explanation.

Paolo
