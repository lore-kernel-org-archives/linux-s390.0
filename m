From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] vfio-ccw: support hsch/csch (kernel
 part)
Date: Mon, 11 Feb 2019 12:37:23 -0500
Message-ID: <75c1f24b-204d-d464-8466-8453f7a0f89c@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190206150016.6fdfaf8f.cohuck@redhat.com>
	<1981d9bc-e950-62ef-d2d2-66a17771c8f4@linux.ibm.com>
	<20190211171354.40be0856.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190211171354.40be0856.cohuck@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>



On 02/11/2019 11:13 AM, Cornelia Huck wrote:
> On Fri, 8 Feb 2019 16:19:58 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
>>
>> FWIW, I've been running with both series for the last week or two, along
>> with some host kernel traces to prove things got executed the way I
>> thought, and it's seemed to be working well.  So that makes me
>> optimistic for the later patches.
> 
> That's good news, thanks for testing. Do you have a special test load
> that you run in the guest that you can share?
> 

Not really.  Lately it's just fio, run via some ancient scripts which 
randomize the input parameters and distill the output data.  If I get 
some time to make it less hack-y it might be worth sharing, but right 
now there's more things commented out than actual script.  :)

  - Eric
