Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25814 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727265AbgA3Nz0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 08:55:26 -0500
Date: Thu, 30 Jan 2020 14:55:12 +0100
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v8 2/4] selftests: KVM: Add fpu and one reg set/get
 library functions
Message-ID: <20200130135512.diyyu3wvwqlwpqlx@kamzik.brq.redhat.com>
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-3-frankja@linux.ibm.com>
 <72ff36e1-9170-dfb0-4050-f398f9a467eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ff36e1-9170-dfb0-4050-f398f9a467eb@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On Thu, Jan 30, 2020 at 11:36:21AM +0100, Thomas Huth wrote:
> On 29/01/2020 21.03, Janosch Frank wrote:
> > Add library access to more registers.
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > ---
> >  .../testing/selftests/kvm/include/kvm_util.h  |  6 +++
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 48 +++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 29cccaf96baf..ae0d14c2540a 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -125,6 +125,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
> >  		    struct kvm_sregs *sregs);
> >  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
> >  		    struct kvm_sregs *sregs);
> > +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
> > +		  struct kvm_fpu *fpu);
> > +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
> > +		  struct kvm_fpu *fpu);
> > +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
> > +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
> >  #ifdef __KVM_HAVE_VCPU_EVENTS
> >  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
> >  		     struct kvm_vcpu_events *events);
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 41cf45416060..dae117728ec6 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -1373,6 +1373,54 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
> >  	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
> >  }
> >  
> > +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> > +{
> > +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> > +	int ret;
> > +
> > +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> > +
> > +	ret = ioctl(vcpu->fd, KVM_GET_FPU, fpu);
> > +	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i",
> > +		    ret, errno);
> > +}
> > +
> > +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> > +{
> > +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> > +	int ret;
> > +
> > +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> > +
> > +	ret = ioctl(vcpu->fd, KVM_SET_FPU, fpu);
> > +	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i",
> > +		    ret, errno);
> > +}
> > +
> > +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
> > +{
> > +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> > +	int ret;
> > +
> > +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> > +
> > +	ret = ioctl(vcpu->fd, KVM_GET_ONE_REG, reg);
> > +	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i",
> > +		    ret, errno);
> > +}
> > +
> > +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
> > +{
> > +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> > +	int ret;
> > +
> > +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> > +
> > +	ret = ioctl(vcpu->fd, KVM_SET_ONE_REG, reg);
> > +	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i",
> > +		    ret, errno);
> > +}
> > +
> >  /*
> >   * VCPU Ioctl
> >   *
> > 
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

How about what's below instead. It should be equivalent.

Thanks,
drew

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 29cccaf96baf..d96a072e69bf 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -125,6 +125,31 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
 		    struct kvm_sregs *sregs);
 int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
 		    struct kvm_sregs *sregs);
+
+static inline void
+vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
+}
+
+static inline void
+vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
+}
+
+static inline void
+vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
+}
+
+static inline void
+vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
+}
+
 #ifdef __KVM_HAVE_VCPU_EVENTS
 void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
